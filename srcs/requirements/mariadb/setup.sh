#!/bin/sh

export $(grep -v '^#' /run/secrets/* | xargs)
DB_CRED="-u root --password=${MYSQL_ROOT_PASSWORD}"

/etc/init.d/mariadb start --defaults-file=/etc/mysql/mariadb.cnf
sleep 1

mariadb $DB_CRED -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mariadb $DB_CRED -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'wordpress.inception' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb $DB_CRED -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'wordpress.inception' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb $DB_CRED -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mariadb $DB_CRED -e "FLUSH PRIVILEGES;"

mariadb-admin $DB_CRED shutdown

chown -R mariadb:inception \
    /run/mysqld            \
    /var/lib/mysql