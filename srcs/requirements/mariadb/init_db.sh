#!/bin/bash

# Inicializa daemon mysql
mysqld --initialize --user=mysql

# Arranca MySQL en segundo plano y espera a que esté listo
mysqld_safe --datadir="/var/lib/mysql" &
sleep 5

echo "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" > tmp.sql
echo "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> tmp.sql
echo "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';" >> tmp.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> tmp.sql
echo "FLUSH PRIVILEGES;" >> tmp.sql

mysql < tmp.sql

# Parar mysqld_safe después de setup
mysqladmin shutdown -uroot -p"${MYSQL_ROOT_PASSWORD}"

# Arranca mariadb en primer plano
exec mysqld
