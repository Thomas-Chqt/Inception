FROM debian:bullseye

ARG domain_name

RUN [ "apt", "update" ]
RUN [ "apt", "install", "-y", "nginx" ]

RUN addgroup --system inception
RUN adduser --system --no-create-home --ingroup inception --shell /usr/sbin/nologin nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY setup.sh /setup.sh

RUN --mount=type=secret,id=inception_secrets chmod +x /setup.sh && /setup.sh && rm /setup.sh

USER nginx:inception
ENTRYPOINT [ "nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;" ]