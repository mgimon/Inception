# Dockerfile para MariaDB personalizado basado en Debian stable penultima version
FROM debian:stable-slim

# ENV MARIADB_VERSION=10.11 // no especificar de momento

# Actualizar paquetes
RUN apt-get update && apt-get install -y \
    mariadb-server=$MARIADB_VERSION* \
    mariadb-client=$MARIADB_VERSION* \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME /var/lib/mysql

EXPOSE 3306

CMD ["mysqld_safe"]
