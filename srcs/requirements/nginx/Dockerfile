FROM debian:bullseye

ARG domain_name

RUN [ "apt", "update" ]
RUN [ "apt", "install", "-y", "nginx" ]

COPY nginx.conf /etc/nginx/nginx.conf

RUN sed -i "s/DOMAIN_NAME/${domain_name}/" /etc/nginx/nginx.conf

RUN apt install -y openssl && \
    openssl req -x509 -nodes \
        -out /etc/ssl/certs/${domain_name}.crt \
        -keyout /etc/ssl/private/${domain_name}.key \
        -subj "/C=JP/ST=TYO/L=Tokyo/O=42/OU=42/CN=${domain_name}" && \
    apt remove -y openssl

RUN chgrp www-data /etc/ssl/private/${domain_name}.key && \
    chmod 040 /etc/ssl/private/${domain_name}.key

ENTRYPOINT [ "nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;" ]