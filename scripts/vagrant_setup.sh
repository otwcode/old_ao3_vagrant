#!/bin/bash

mkdir /tmp/vbox
VER=$(cat /home/vagrant/.vbox_version)
wget -nc http://download.virtualbox.org/virtualbox/$VER/VBoxGuestAdditions_$VER.iso
mount -o loop VBoxGuestAdditions_$VER.iso /tmp/vbox
sh /tmp/vbox/VBoxLinuxAdditions.run
umount /tmp/vbox
rmdir /tmp/vbox
rm *.iso

# Installing vagrant keys
mkdir ~/.ssh
chmod 700 ~/.ssh
cd ~/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chmod 600 ~/.ssh/authorized_keys
chown -R vagrant ~/.ssh

