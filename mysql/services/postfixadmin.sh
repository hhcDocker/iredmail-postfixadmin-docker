#!/bin/sh
# MySQL actually runs
#while ! mysqladmin ping -h localhost --silent; do
#  sleep 1; 
#done

. /opt/iredmail/.cv
POSTMASTER_ADMIN_PASSWORD=$(echo $POSTMASTER_PASSWORD | sed 's/{MD5-CRYPT}//')
mysql -u vmailadmin -p$VMAIL_DB_ADMIN_PASSWD -e "\
UPDATE admin SET username = 'postmaster@$DOMAIN', password = '$POSTMASTER_ADMIN_PASSWORD' WHERE username='postmaster@DOMAIN';\
UPDATE alias SET address=concat(left(address,length(address) -6),'$DOMAIN') WHERE address LIKE '%DOMAIN';\
UPDATE alias SET domain='$DOMAIN' WHERE domain = 'DOMAIN';\
UPDATE alias SET goto=concat(left(goto,length(goto) -6),'$DOMAIN') WHERE goto LIKE '%DOMAIN';\
UPDATE domain SET domain = '$DOMAIN' WHERE domain = 'DOMAIN';\
UPDATE domain_admins SET username=concat(left(username,length(username) -6),'$DOMAIN') WHERE username LIKE '%DOMAIN';\
UPDATE forwardings SET address=concat(left(address,length(address) -6),'$DOMAIN') WHERE address LIKE '%DOMAIN';\
UPDATE forwardings SET forwarding=concat(left(forwarding,length(forwarding) -6),'$DOMAIN') WHERE forwarding LIKE '%DOMAIN';\
UPDATE forwardings SET domain = '$DOMAIN' WHERE domain = 'DOMAIN';\
UPDATE forwardings SET dest_domain = '$DOMAIN' WHERE dest_domain = 'DOMAIN';" vmail

sed -i "s/TEMP_VMAIL_DB_ADMIN_PASSWD/$VMAIL_DB_ADMIN_PASSWD/" /opt/www/postfixadmin-3.1/config.local.php
#sed -i "s/TEMP_SETUP_PASSWORD/$(openssl rand -hex 32)/" /opt/www/postfixadmin-3.1/config.local.php
sed -i "s/TEMP_DOMAIN/$DOMAIN/" /opt/www/postfixadmin-3.1/config.local.php

