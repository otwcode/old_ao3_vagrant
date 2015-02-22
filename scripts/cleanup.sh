#!/bin/bash  -x

set -e

cleanup() {
   rm -f /EMPTY
   exit 0
}
trap "cleanup" INT TERM EXIT
rm -f /home/vagrant/VBoxGuestAdditions*.iso
# Remove APT cache
apt-get clean -y
apt-get autoclean -y


#cleanup log files
find /var/log -type f | while read f; do echo -ne '' > $f; done;

# Whiteout /boot
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count;
rm /boot/whitespace;

swappart=`cat /proc/swaps | tail -n1 | awk -F ' ' '{print $1}'`
swapoff $swappart;
dd if=/dev/zero of=$swappart;
mkswap $swappart;
swapon $swappart;


rm -f /EMPTY
exit 0
