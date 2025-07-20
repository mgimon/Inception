FROM debian:bullseye

RUN mkdir -p /run/php

RUN apt-get update && apt-get -y install \
 curl \
 php7.4-fpm \
 php7.4-mysqli \
 mariadb-client

# Descargar wp-cli.phar (PHP) y asociarlo a "wp"
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

COPY ./init_wordpress.sh /init_wordpress.sh
RUN chmod +x /init_wordpress.sh

ENTRYPOINT ["/init_wordpress.sh"]
