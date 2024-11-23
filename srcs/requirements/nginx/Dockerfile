FROM debian:bullseye

ARG DOMAIN_NAME

RUN [ "apt", "update" ]
RUN [ "apt", "install", "-y", "nginx" ]

COPY nginx.conf /etc/nginx/nginx.conf

RUN sed -i "s/DOMAIN_NAME/${DOMAIN_NAME}/" /etc/nginx/nginx.conf

RUN apt install -y openssl && \
    openssl req -x509 -nodes \
        -out /etc/ssl/certs/${DOMAIN_NAME}.crt \
        -keyout /etc/ssl/private/${DOMAIN_NAME}.key \
        -subj "/C=JP/ST=TYO/L=Tokyo/O=42/OU=42/CN=${DOMAIN_NAME}" && \
    apt remove -y openssl

RUN chgrp www-data /etc/ssl/private/${DOMAIN_NAME}.key && \
    chmod 040 /etc/ssl/private/${DOMAIN_NAME}.key

ENTRYPOINT [ "nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;" ]