#!/bin/bash
# utilities/linux-info.sh

# Run as root, with tee to a file
# sudo ./linux-info.sh | tee -a linux-info.txt
echo -e "# linux-info.sh - $(date) "
echo -e "---"

echo -e "\n## Host summary"
hostnamectl
uptime -p
uptime -s

echo -e "\n## CPU model and topology"
lscpu | grep -E 'Model name|^CPU\(s\)|Socket|Core|Thread|MHz|Virtualization'

echo -e "\n## Usable memory and swap"
free -h

echo -e "\n## Local filesystems only"
df -hT -x tmpfs -x devtmpfs -x squashfs

echo -e "\n## Disk type: TRAN is nvme/sata/usb, ROTA 1 means spinning"
lsblk -o NAME,SIZE,ROTA,TRAN,MODEL,SERIAL,FSTYPE,MOUNTPOINT

echo -e "\n## GPU and network"
lspci -nn | grep -Ei 'vga|3d|display'
ip -br addr
ip route show default

echo -e "\n## USB topology"
lsusb -t
