##
## utilities/linux-info.sh
##

# System version
# Show number of CPUs
# View memory size
# Check filesystem size

uname -vrps
lscpu | grep -E '^CPU\(s\)|Socket|Core|Thread'
free -h | awk '/Mem:/ {print "Total memory:", $2}'
df -h 

# To update Ubuntu system:
sudo apt-get --yes update
sudo apt-get --yes upgrade
sudo reboot
