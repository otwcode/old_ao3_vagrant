#!/bin/bash 

set -e
rsync -av /var/tmp/files/ /
gzip -f /home/vagrant/conf/seed.dump

(while read line; do
FILEN="$( echo $line | awk '{print $1}' )"
OWNER="$( echo $line | awk '{print $2}' )"
PERMS="$( echo $line | awk '{print $3}' )"
chown $OWNER $FILEN
chmod $PERMS $FILEN
done
) <<EOT
/etc/squid3/squid.conf root:root 755
/etc/memcached.conf root:root 755
/etc/init.d/redis-server2 root:root 755
/etc/init.d/redis-server1 root:root 755
/etc/redis/redis.conf root:root 755
/etc/redis/redis2.conf root:root 755
/etc/redis/redis1.conf root:root 755
/etc/nginx/sites-available/ao3.conf root:root 755
/etc/nginx/sites-available/rewrite.conf root:root 755
/ root:root 755
/etc root:root 755
/etc/redis root:root 755
/etc/squid3 root:root 755
/etc/nginx root:root 755
/etc/nginx/sites-available root:root 755 
/etc/nginx/sites-enabled root:root 755
/root root:root 700
/tmp root:root 1777
/home/vagrant vagrant:vagrant 755
/home/vagrant/.my.cnf vagrant:vagrant 700
/home/vagrant/bin vagrant:vagrant 755
/home/vagrant/bin/run_cucumber vagrant:vagrant 755
/home/vagrant/bin/kill_my_unicorns vagrant:vagrant 755
/home/vagrant/bin/reset_perl vagrant:vagrant 755
/home/vagrant/bin/start_my_unicorns vagrant:vagrant 755
/home/vagrant/bin/start_my_workers vagrant:vagrant 755
/home/vagrant/bin/reset_rvm vagrant:vagrant 755
/home/vagrant/bin/seed vagrant:vagrant 755
/home/vagrant/bin/start_mailcatcher vagrant:vagrant 755
/home/vagrant/bin/kill_my_workers vagrant:vagrant 755
/home/vagrant/bin/reload_elastic vagrant:vagrant 755
/home/vagrant/conf vagrant:vagrant 755
/home/vagrant/conf/local.yml vagrant:vagrant 644
/home/vagrant/conf/skins.dump vagrant:vagrant 644
/home/vagrant/conf/redis.yml vagrant:vagrant 644
/home/vagrant/conf/database.yml vagrant:vagrant 644
/home/vagrant/conf/redis-cucumber.conf vagrant:vagrant 644
/home/vagrant/conf/seed.dump.gz vagrant:vagrant 644
/home/vagrant/conf/unicorn.rb vagrant:vagrant 644
/home/vagrant/app  vagrant:vagrant 755
/home/vagrant/app/deploy  vagrant:vagrant 755
/home/vagrant/.bash_logout vagrant:vagrant 755
/home/vagrant/.bash_profile vagrant:vagrant 755
/home/vagrant/.bashrc vagrant:vagrant 755
/usr/local/etc/art/ root:root 755
/usr/local/etc/art/unicorn_12 root:root 755
/usr/local/etc/art/unicorn_5 root:root 755
/usr/local/etc/art/unicorn_9 root:root 755
/usr/local/etc/art/unicorn_3 root:root 755
/usr/local/etc/art/unicorn_7 root:root 755
/usr/local/etc/art/unicorn_1 root:root 755
/usr/local/etc/art/unicorn_10 root:root 755
/usr/local/etc/art/unicorn_8 root:root 755
/usr/local/etc/art/unicorn_11 root:root 755
/usr/local/etc/art/unicorn_4 root:root 755
/usr/local/etc/art/unicorn_2 root:root 755
/usr/local/etc/art/unicorn_6 root:root 755
EOT

(while read line; do
FILE_SRC="$( echo $line | awk '{print $1}' )"
FILE_DST="$( echo $line | awk '{print $2}' )"
ln -s $FILE_SRC $FILE_DST
done
) <<EOT
/etc/init.d/redis-server1 /etc/rc2.d/S20redis-server1
/etc/init.d/redis-server2 /etc/rc2.d/S20redis-server2
/etc/init.d/redis-server1 /etc/rc6.d/K20redis-server1
/etc/init.d/redis-server2 /etc/rc6.d/K20redis-server2
/etc/init.d/mysql /etc/rc2.d/S20mysql
/etc/init.d/mysql /etc/rc6.d/K20mysql
EOT
reboot
