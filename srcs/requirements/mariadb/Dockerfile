FROM debian:bullseye

RUN [ "apt", "update" ]
RUN [ "apt", "install", "-y", "mariadb-server" ]

COPY mariadb.cnf /etc/mysql/mariadb.cnf
COPY setup.sh /setup.sh

RUN --mount=type=secret,id=inception_secrets chmod +x /setup.sh && /setup.sh && rm /setup.sh

ENTRYPOINT [ "mariadbd-safe", "--defaults-file=/etc/mysql/mariadb.cnf" ]