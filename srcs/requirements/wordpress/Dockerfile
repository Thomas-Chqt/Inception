FROM debian:bullseye

RUN [ "apt", "update" ]
RUN [ "apt", "install", "-y", "php-fpm", "php-mysql" ]

COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
COPY setup.sh /setup.sh

RUN adduser --system --no-create-home --ingroup www-data --shell /usr/sbin/nologin php-fpm
RUN --mount=type=secret,id=inception_secrets chmod +x /setup.sh && /setup.sh && rm /setup.sh

USER php-fpm:www-data
ENTRYPOINT [ "php-fpm7.4", "-F" ]