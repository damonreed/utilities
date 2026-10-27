# utilities/linux-usb.sh
#
# Linux USB device inspection and analysis script
#

# Phase 0 - Setup - Ubuntu 
sudo apt update
sudo apt install --no-install-recommends smartmontools
sudo apt install usbutils parted gddrescue f3 exfatprogs


# Phase 1 — Identify the device and link
## Begin with USB device not connected to the system
## Start log scroll in separate terminal
sudo dmesg -wT

## Plug in USB device and observe the output in dmesg terminal

## Use lsusb and lsblk to get device information
lsusb -t                                    # negotiated speed: 5000M+ = USB 3, 480M = USB 2
lsblk -o NAME,SIZE,MODEL,SERIAL,FSTYPE,MOUNTPOINT

## Set device variable
DEV=/dev/sdb                                # set this from lsblk output; every later step uses it


# Phase 2 — SMART check and inspect the drive enclosure for USB external drives
sudo hdparm -I $DEV | grep "Model Number:"
sudo smartctl -a $DEV
sudo smartctl -a -d sat $DEV


# Phase 3 — Inspect the partition layout
sudo fdisk -l $DEV
# sudo fdisk -l -u $DEV
sudo parted -l $DEV


# Phase 4 — Read-only surface scan and image using ddrescue 
# This will exercise the drive and identify bad sectors and create an image file

## For data you want to keep, run a read-only pass with ddrescue and create an image file
## A failing controller can die under sustained reads, and the map file records the bad regions.
sudo ddrescue -d -n $DEV drive.img drive.map      # fast pass, skips bad areas
sudo ddrescue -d -r3 $DEV drive.img drive.map     # go back and retry bad areas

## If the data is disposable, run a straight read pass with dmesg -wT open in another terminal:
sudo dd if=$DEV of=/dev/null bs=4M iflag=direct status=progress  # read-only pass


# Phase 5 — Fresh write/read discriminator (destructive)
## Writing fresh data and reading it straight back separates a drive whose old data had decayed from one with a failing controller or NAND.
sudo umount ${DEV}* 2>/dev/null
sudo wipefs -a $DEV

## Stage 2GiB of random data on the local disk (avoids a /dev/urandom bottleneck)
dd if=/dev/urandom of=/tmp/t.bin bs=4M count=512

## Write it raw to the drive, then read it back with the cache bypassed
sudo dd if=/tmp/t.bin of=$DEV bs=4M oflag=direct status=progress
sudo dd if=$DEV of=/dev/null bs=4M count=512 iflag=direct status=progress

## Verify integrity
echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
sudo cmp -n 2147483648 /tmp/t.bin $DEV && echo MATCH
rm /tmp/t.bin


# Phase 6 — Full-capacity verification (destructive)
## Create a new partition and format it
sudo parted -s $DEV mklabel gpt mkpart data ext4 1MiB 100%
sleep 10 # Needed for slow drives
sudo mkfs.ext4 -L test ${DEV}1
sudo mkdir -p /mnt/fit
sudo mount ${DEV}1 /mnt/fit && findmnt /mnt/fit && sudo f3write /mnt/fit && sudo f3read /mnt/fit
sudo umount /mnt/fit


# Phase 7 — Reformat for use as a Win/Mac/Linux exfat data drive
## Repartition and format the drive as exfat
sudo wipefs -a ${DEV}1 2>/dev/null           # clear any old filesystem signature
sudo wipefs -a $DEV
sudo parted -s $DEV mklabel gpt mkpart LABEL fat32 1MiB 100%
sudo parted -s $DEV set 1 msftdata on
sudo mkfs.exfat -L LABEL ${DEV}1


# Phase 8 — Verify the exfat filesystem on Linux, Mac, and Windows
## Linux
lsblk -o NAME,PARTTYPE,FSTYPE,LABEL $DEV
sudo fsck.exfat -n ${DEV}1

## Mac
diskutil list
diskutil unmountDisk ${DEV}1
sudo fsck -fy ${DEV}1

## Windows
diskpart
list disk
select disk ${DEV}
list partition
select partition 1
convert gpt