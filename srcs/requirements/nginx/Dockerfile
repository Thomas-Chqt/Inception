FROM debian:bullseye

RUN [ "apt", "update" ]
RUN [ "apt", "install", "-y", "nginx" ]

COPY nginx.conf /etc/nginx/nginx.conf
COPY setup.sh /setup.sh

RUN adduser --system --no-create-home --ingroup www-data --shell /usr/sbin/nologin nginx
RUN --mount=type=secret,id=inception_secrets chmod +x /setup.sh && /setup.sh && rm /setup.sh

USER nginx:www-data
ENTRYPOINT [ "nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;" ]