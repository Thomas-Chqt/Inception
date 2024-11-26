#!/bin/sh
export $(grep -v '^#' /run/secrets/* | xargs) 
sed -i "s/DOMAIN_NAME/${DOMAIN_NAME}/" /etc/nginx/nginx.conf
apt install -y openssl
openssl req -x509 -nodes \
    -out /etc/ssl/certs/${DOMAIN_NAME}.crt \
    -keyout /etc/ssl/private/${DOMAIN_NAME}.key \
    -subj "/C=JP/ST=TYO/L=Tokyo/O=42/OU=42/CN=${DOMAIN_NAME}"
apt remove -y openssl
chown -R www-data:www-data /etc/ssl/private
chown -R www-data:www-data /var/log/nginx
chown -R www-data:www-data /var/lib/nginx
touch /run/nginx.pid
chown -R www-data:www-data /run/nginx.pid