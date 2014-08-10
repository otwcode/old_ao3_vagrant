#!/bin/bash -x 

set -e

echo Installing mysql server
# Install mysql
echo 'mysql-server mysql-server/root_password password root' |  sudo debconf-set-selections
echo 'mysql-server mysql-server/root_password_again password root' | sudo debconf-set-selections
apt-get -y -q install  mysql-server-5.6
