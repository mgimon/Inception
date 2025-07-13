FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl

EXPOSE 443

#COPY ./index.html var/www/html/index.html
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./init_nginx.sh /init_nginx.sh

RUN chmod +x /init_nginx.sh

ENTRYPOINT ["/init_nginx.sh"]
