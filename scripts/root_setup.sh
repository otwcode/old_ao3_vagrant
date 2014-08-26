#!/bin/bash

set -e
# Configure mysql
echo 'mysql-server mysql-server/root_password password root'       | debconf-set-selections
echo 'mysql-server mysql-server/root_password_again password root' | debconf-set-selections


# Updating and Upgrading dependencies
apt-get update -y -qq > /dev/null
apt-get upgrade -y -qq > /dev/null

# Install necessary libraries for guest additions and Vagrant NFS Share
apt-get -y -q install linux-headers-$(uname -r) build-essential dkms nfs-common


# Install necessary dependencies
apt-get -y -q install curl wget git tmux firefox xvfb vim atop

# Setup sudo to allow no-password sudo for "admin"
groupadd -r admin
usermod -a -G admin vagrant
cp /etc/sudoers /etc/sudoers.orig
sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers

# required for downloads
apt-get install -y -q calibre 
# memcached
apt-get -y -q install  memcached
# mysql
apt-get -y -q install  mysql-server  libmysqlclient-dev  
/etc/init.d/mysql start
# nginx
apt-get -y -q install nginx
# redis
apt-get install -y -q  redis-server 
# rvm
apt-get install -y -q  gawk libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev
# squid
apt-get install -y -q  squid3

