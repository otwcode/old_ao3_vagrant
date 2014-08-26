#!/bin/bash  -x

set -e

cleanup() {
   rm -f /EMPTY
   exit 0
}
trap "cleanup" INT TERM EXIT
rm -f /home/vagrant/VBoxGuestAdditions*.iso
rm -f /var/cache/apt/archives/*.deb
dd if=/dev/zero of=/EMPTY bs=1M 
rm -f /EMPTY
exit 0
