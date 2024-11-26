#!/bin/sh
export $(grep -v '^#' /run/secrets/* | xargs)
apt install -y wget
wget -P /var/www https://wordpress.org/latest.tar.gz
tar -xzvf /var/www/latest.tar.gz -C /var/www
rm /var/www/latest.tar.gz
apt remove -y wget