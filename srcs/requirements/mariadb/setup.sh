#!/bin/sh
export $(grep -v '^#' /run/secrets/* | xargs)
service mariadb start
mariadb -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'wordpress' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'wordpress' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb -e "FLUSH PRIVILEGES;"
service mariadb stop