FROM debian:bullseye

ARG mysql_database
ARG mysql_user

RUN [ "apt", "update" ]
RUN [ "apt", "upgrade" ]
RUN [ "apt", "install", "-y", "mariadb-server" ]

COPY mariadb.cnf /etc/mysql/mariadb.cnf

RUN service mariadb start

RUN mariadb -e "CREATE DATABASE IF NOT EXISTS ${mysql_database};"

RUN --mount=type=secret,id=mysql_password,env=MYSQL_PASSWORD \
    mysql -e "CREATE USER IF NOT EXISTS '${mysql_user}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"

RUN --mount=type=secret,id=mysql_password,env=MYSQL_PASSWORD \
    mysql -e "GRANT ALL PRIVILEGES ON ${mysql_database}.* TO '${mysql_user}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"

RUN --mount=type=secret,id=mysql_root_password,env=MYSQL_ROOT_PASSWORD \
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'"

RUN mysql -e "FLUSH PRIVILEGES;"

RUN --mount=type=secret,id=mysql_root_password,env=MYSQL_ROOT_PASSWORD \
    mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

ENTRYPOINT [ "mysqld_safe", "--defaults-file=/etc/mysql/mariadb.cnf" ]