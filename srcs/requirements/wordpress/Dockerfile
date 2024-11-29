FROM debian:bullseye

RUN [ "apt", "update" ]
RUN [ "apt", "install", "-y", "php-fpm", "php-mysql" ]

COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf

RUN addgroup --system inception
RUN adduser --system --no-create-home --ingroup inception --shell /usr/sbin/nologin php-fpm

RUN [ "apt", "install", "-y", "wget" ]

RUN wget -P /var/www https://wordpress.org/latest.tar.gz && tar -xzvf /var/www/latest.tar.gz -C /var/www && rm /var/www/latest.tar.gz

COPY setup.sh /setup.sh
RUN --mount=type=secret,id=inception_secrets chmod +x /setup.sh && /setup.sh && rm /setup.sh

RUN ["apt", "remove", "-y", "wget"]

USER php-fpm:inception
ENTRYPOINT wp-install && echo "" > $(which wp-install) && php-fpm7.4 -F