FROM debian:bullseye

RUN [ "apt", "update" ]
RUN [ "apt", "install", "-y", "mariadb-server" ]

COPY mariadb.cnf /etc/mysql/mariadb.cnf

ENTRYPOINT [ "mysqld_safe", "--defaults-file=/etc/mysql/mariadb.cnf" ]