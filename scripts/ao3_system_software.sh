#!/bin/bash

set -e
 
bash /var/tmp/files/root/mysql_setup.sh
bash /var/tmp/files/root/redis_setup.sh
bash /var/tmp/files/root/memcached_setup.sh
bash /var/tmp/files/root/nginx_setup.sh
bash /var/tmp/files/root/squid_setup.sh
true
