#!/bin/bash

echo Install elasticsearch
cd /tmp
if [ `uname -i` = "x86_64" ] ; then
  wget http://media.transformativeworks.org/ao3/vagrant/jdk-7u67-linux-x64.tar.gz
  mkdir -p /usr/otw
  cd /usr/otw
  tar xvf /tmp/jdk-7u67-linux-x64.tar.gz
else
  wget http://media.transformativeworks.org/ao3/vagrant/jdk-7u67-linux-i586.tar.gz
  mkdir -p /usr/otw
  cd /usr/otw
  tar xvf /tmp/jdk-7u67-linux-i586.tar.gz
fi
export JAVA_HOME=/usr/otw/jdk1.7.0_67 
cd /tmp
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.12.deb
dpkg --install elasticsearch-0.90.12.deb 
echo "JAVA_HOME=/usr/otw/jdk1.7.0_67" >> /etc/default/elasticsearch 
