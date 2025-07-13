FROM debian:bullseye

RUN apt-get update && apt-get -y install \
 curl \
 php7.3-fpm \
 php7.3-mysqli \
 mariadb-client

# Descargar WP-CLI y asociarlo al PATH para "wp"
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY ./init_worpress.sh /init_wordpress.sh
RUN chmod +x /init_wordpress.sh

ENTRYPOINT ["/init_wordpress.sh"]
