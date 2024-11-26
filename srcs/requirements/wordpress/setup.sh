#!/bin/sh

export $(grep -v '^#' /run/secrets/* | xargs)

apt install -y wget

wget -P /var/www https://wordpress.org/latest.tar.gz
tar -xzvf /var/www/latest.tar.gz -C /var/www
rm /var/www/latest.tar.gz

touch /run/php7.4-fpm.pid
mkdir -p /var/log/php

CONF=/var/www/wordpress/wp-config-sample.php
{ sed -n '1,50p' $CONF; wget -qO- https://api.wordpress.org/secret-key/1.1/salt/; sed -n '59,$p' $CONF; } > /tmp/conf.tmp
mv /tmp/conf.tmp $CONF
sed -i "s/database_name_here/${MYSQL_DATABASE}/" $CONF
sed -i "s/username_here/${MYSQL_USER}/" $CONF
sed -i "s/password_here/${MYSQL_PASSWORD}/" $CONF
sed -i "s/localhost/mariadb:3360/" $CONF

# debug
sed -i "s/define( 'WP_DEBUG', false );/define( 'WP_DEBUG', true );/" $CONF
{ sed -n '1,91p' $CONF; echo "define( 'WP_DEBUG_LOG', true );"; sed -n '93,$p' $CONF; } > /tmp/conf.tmp
mv /tmp/conf.tmp $CONF
#end debug

mv $CONF /var/www/wordpress/wp-config.php 
chmod 600 /var/www/wordpress/wp-config.php 

chown -R php-fpm:www-data \
    /var/log/php          \
    /run/php7.4-fpm.pid   \
    /var/www/wordpress
    
apt remove -y wget