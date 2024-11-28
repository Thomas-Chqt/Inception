#!/bin/sh

export $(grep -v '^#' /run/secrets/* | xargs)

WP_CONFIG_SAMPLE=/var/www/wordpress/wp-config-sample.php
WP_CONFIG=/var/www/wordpress/wp-config.php

sed -n '1,50p' $WP_CONFIG_SAMPLE > $WP_CONFIG
wget -qO- https://api.wordpress.org/secret-key/1.1/salt/ >> $WP_CONFIG
sed -n '59,$p' $WP_CONFIG_SAMPLE >> $WP_CONFIG

sed -i "s/database_name_here/${MYSQL_DATABASE}/" $WP_CONFIG
sed -i "s/username_here/${MYSQL_USER}/" $WP_CONFIG
sed -i "s/password_here/${MYSQL_PASSWORD}/" $WP_CONFIG
sed -i "s/localhost/mariadb/" $WP_CONFIG

# debug
# sed -i "s/define( 'WP_DEBUG', false );/define( 'WP_DEBUG', true );/" $WP_CONFIG
#end debug

wget /usr/local/bin https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

chmod 600 $WP_CONFIG

echo "wp core install \\
    --path=/var/www/wordpress \\
    --url=${DOMAIN_NAME} \\
    --title=Inception \\
    --admin_user=${WP_ADMIN_USER} \\
    --admin_password=${WP_ADMIN_PW} \\
    --admin_email=${WP_ADMIN_MAIL} \\
    --skip-email
php-fpm7.4 -F" > /entrypoint.sh

touch /run/php7.4-fpm.pid
mkdir -p /var/log/php

chown -R php-fpm:inception \
    /var/log/php           \
    /run/php7.4-fpm.pid    \
    /var/www/wordpress     \
    /entrypoint.sh