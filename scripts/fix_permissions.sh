#!/bin/bash 

set -e
 
rsync -av /var/tmp/files/ /

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
/root/redis_setup.sh root:root 755
/root/mysql_setup.sh root:root 755
/ root:root 755
/etc root:root 755
/etc/redis root:root 755
/etc/squid3 root:root 755
/etc/nginx root:root 755
/etc/nginx/sites-available root:root 755 
/etc/nginx/sites-enabled root:root 755
/root root:root 700
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

