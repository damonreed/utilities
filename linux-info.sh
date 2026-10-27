##
## utilities/linux-info.sh
##

# System version
# Show number of CPUs
# View memory size
# Check filesystem size

uname -snrvm
lscpu | grep -E '^CPU\(s\)|Socket|Core|Thread'
free -h | awk '/Mem:/ {print "Total memory:", $2}'
df -h 

# USB and block device information
lsusb -t
lsblk -o NAME,SIZE,MODEL,SERIAL,FSTYPE,MOUNTPOINT

