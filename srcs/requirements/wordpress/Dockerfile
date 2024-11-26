FROM debian:bullseye

RUN [ "apt", "update" ]
RUN [ "apt", "install", "-y", "php-fpm", "php-mysql" ]

COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
COPY setup.sh /setup.sh

RUN --mount=type=secret,id=inception_secrets chmod +x /setup.sh && /setup.sh && rm /setup.sh

ENTRYPOINT [ "php-fpm7.4", "-F" ]