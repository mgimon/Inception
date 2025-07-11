FROM debian:bullseye

# Evitar preguntas de zona horaria o similares
#ENV DEBIAN_FRONTEND=noninteractive

# Instalar MariaDB
RUN apt-get update -y && \
    apt-get install -y mariadb-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copiar script de inicialización
COPY ./init_db.sh /init_db.sh
RUN chmod +x /init_db.sh

# Volumen para persistencia de datos
VOLUME /var/lib/mysql

# Exponer puerto
EXPOSE 3306

# Comando de arranque
CMD ["/init_db.sh"]
