#!/bin/sh
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "[INFO] Inicializando base de datos..."
    mysqld --initialize-insecure --user=mysql
    echo "[INFO] Iniciando MariaDB en segundo plano..."
    mysqld --skip-networking &
    pid="$!"

    echo "[INFO] Esperando a que MariaDB arranque..."
    while ! mysqladmin ping --silent; do
        sleep 1
    done

    echo "[INFO] Creando base de datos y usuario..."
    mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;"
    mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO '${MYSQL_USER}'@'%';"
    mysql -e "FLUSH PRIVILEGES;"

    echo "[INFO] Deteniendo MariaDB de setup..."
    mysqladmin shutdown

    wait "$pid"
fi

exec mysqld
