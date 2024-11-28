FROM debian:bullseye

RUN [ "apt", "update" ]
RUN [ "apt", "install", "-y", "mariadb-server" ]

RUN addgroup --system inception
RUN adduser --system --no-create-home --ingroup inception --shell /usr/sbin/nologin mariadb

COPY mariadb.cnf /etc/mysql/mariadb.cnf
COPY setup.sh /setup.sh

RUN --mount=type=secret,id=inception_secrets chmod +x /setup.sh && /setup.sh && rm /setup.sh

USER mariadb:inception
ENTRYPOINT [ "mariadbd-safe", "--defaults-file=/etc/mysql/mariadb.cnf"]