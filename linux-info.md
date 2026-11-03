# linux-info.sh - Tue Nov  3 02:17:11 PM UTC 2026
---

## Host summary
 Static hostname: monolith
       Icon name: computer-desktop
         Chassis: desktop
      Machine ID: ec3022cb962f496b9d18b4523e0984d5
         Boot ID: ffcab8b17b184e2982ba278741f86ce6
Operating System: Ubuntu 22.04.5 LTS
          Kernel: Linux 5.15.0-198-generic
    Architecture: x86-64
 Hardware Vendor: Gigabyte Technology Co., Ltd.
  Hardware Model: H170-D3HP
up 2 weeks, 15 hours, 10 minutes
2026-10-19 23:07:00

## CPU model and topology
CPU(s):                                  8
Model name:                              Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
Thread(s) per core:                      2
Core(s) per socket:                      4
Socket(s):                               1
CPU max MHz:                             4200.0000
CPU min MHz:                             800.0000
Virtualization:                          VT-x

## Usable memory and swap
               total        used        free      shared  buff/cache   available
Mem:            31Gi       667Mi        26Gi       5.0Mi       4.5Gi        30Gi
Swap:          8.0Gi       0.0Ki       8.0Gi

## Local filesystems only
Filesystem                        Type  Size  Used Avail Use% Mounted on
/dev/mapper/ubuntu--vg-ubuntu--lv ext4   98G   19G   75G  20% /
/dev/nvme0n1p2                    ext4  2.0G  260M  1.6G  15% /boot
/dev/sda                          ext4  458G  281G  154G  65% /home
/dev/nvme0n1p1                    vfat  1.1G  6.1M  1.1G   1% /boot/efi

## Disk type: TRAN is nvme/sata/usb, ROTA 1 means spinning
NAME          SIZE ROTA TRAN   MODEL               SERIAL    FSTYPE  MOUNTPOINT
loop0        63.8M    0                                      squashf /snap/core2
loop1        63.8M    0                                      squashf /snap/core2
loop2          74M    0                                      squashf /snap/core2
loop3          74M    0                                      squashf /snap/core2
loop5       115.2M    0                                      squashf /snap/lxd/4
loop6        50.3M    0                                      squashf /snap/snapd
loop7        44.7M    0                                      squashf /snap/snapd
loop8       116.6M    0                                      squashf /snap/lxd/4
sda         465.8G    0 sata   Samsung SSD 860     S3Z1NB0K1 ext4    /home
nvme0n1     238.5G    0 nvme   Samsung SSD 950 PRO S2GLNX0H8
├─nvme0n1p1     1G    0 nvme                                 vfat    /boot/efi
├─nvme0n1p2     2G    0 nvme                                 ext4    /boot
└─nvme0n1p3 235.4G    0 nvme                                 LVM2_me
  └─ubuntu--vg-ubuntu--lv
              100G    0                                      ext4    /

## GPU and network
00:02.0 VGA compatible controller [0300]: Intel Corporation HD Graphics 530 [8086:1912] (rev 06)
lo               UNKNOWN        127.0.0.1/8 ::1/128
enp0s31f6        UP             192.168.0.32/24 metric 100 fd62:442:77eb:4b20:428d:5cff:febd:79c9/64 fe80::428d:5cff:febd:79c9/64
default via 192.168.0.1 dev enp0s31f6 proto dhcp src 192.168.0.32 metric 100

## USB topology
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 10000M
    |__ Port 1: Dev 16, If 0, Class=Hub, Driver=hub/4p, 10000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 480M
    |__ Port 1: Dev 10, If 0, Class=Hub, Driver=hub/4p, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/8p, 5000M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/16p, 480M
    |__ Port 9: Dev 2, If 0, Class=Vendor Specific Class, Driver=, 12M