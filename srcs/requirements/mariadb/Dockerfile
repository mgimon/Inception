FROM debian:bullseye

RUN apt-get update -y && apt-get install mariadb-server -y

COPY ./init_db.sh /init_db.sh
RUN chmod +x /init_db.sh

# Comando de arranque
CMD ["/init_db.sh"]
