sysbench cpu --threads=16 run
sysbench fileio --file-test-mode=rndrw run

dd if=/dev/zero of=~/test1.img bs=1G count=1 oflag=dsync
dd if=/dev/zero of=/media/disk1/test2.img bs=512 count=1000 oflag=dsync

df -Th
lsblk -f
lsblk --fs
lshw -class disk
lsusb -t

