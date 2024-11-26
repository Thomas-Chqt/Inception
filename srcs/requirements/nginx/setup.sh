#!/bin/sh
export $(grep -v '^#' /run/secrets/* | xargs) 
sed -i "s/DOMAIN_NAME/${DOMAIN_NAME}/" /etc/nginx/nginx.conf
apt install -y openssl
openssl req -x509 -nodes \
    -out /etc/ssl/certs/${DOMAIN_NAME}.crt \
    -keyout /etc/ssl/private/${DOMAIN_NAME}.key \
    -subj "/C=JP/ST=TYO/L=Tokyo/O=42/OU=42/CN=${DOMAIN_NAME}"
apt remove -y openssl
chmod 755 /etc/ssl/private
touch /run/nginx.pid
mkdir -p /var/cache/nginx
chown -R nginx:www-data                 \
    /etc/ssl/certs/${DOMAIN_NAME}.crt   \
    /etc/ssl/private/${DOMAIN_NAME}.key \
    /var/log/nginx                      \
    /var/lib/nginx                      \
    /run/nginx.pid                      \
    /var/cache/nginx