#!/bin/bash
set -e

domain=$1
read -sp 'MySQL root password: ' password
echo ""
read -sp "New postmaster@$domain password: " postmasterPassword
echo ""

postmasterMD5="$(openssl passwd -1 $postmasterPassword)"

docker run -d --privileged -p 80:80 -p 443:443 -p 25:25 -p 587:587 -p 110:110 -p 143:143 -p 993:993 -p 995:995 \
           -h mail.$domain \
           -e "MYSQL_ROOT_PASSWORD=$password" \
           -e "TZ=Europe/Berlin" \
           -e "POSTMASTER_PASSWORD={MD5-CRYPT}$postmasterMD5" \
           -e "IREDAPD_PLUGINS=['reject_null_sender', 'reject_sender_login_mismatch', 'greylisting', 'throttle', 'amavisd_wblist', 'sql_alias_access_policy']" \
           -v /opt/containers/iredmail/mysql:/var/lib/mysql \
           -v /opt/containers/iredmail/vmail:/var/vmail \
           -v /opt/containers/iredmail/clamav:/var/lib/clamav \
           -v /opt/containers/iredmail/dkim/$domain.pem:/var/lib/dkim/$domain.pem \
           -v /etc/letsencrypt/live/mail.$domain/privkey.pem:/etc/ssl/private/iRedMail.key:ro \
           -v /etc/letsencrypt/live/mail.$domain/fullchain.pem:/etc/ssl/certs/iRedMail.crt:ro \
           --restart unless-stopped \
           --name=iredmail infiniteluke/iredmail-postfixadmin
