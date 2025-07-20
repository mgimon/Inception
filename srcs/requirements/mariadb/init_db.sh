#!/bin/bash

# Inicializa daemon mysql
mysqld --initialize --user=mysql

# Arranca el daemon en modo seguro
mysqld_safe --datadir="/var/lib/mysql" &
sleep 5

# Inserta instrucciones
echo "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" > tmp.sql
echo "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> tmp.sql
echo "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';" >> tmp.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> tmp.sql
echo "FLUSH PRIVILEGES;" >> tmp.sql

mysql < tmp.sql

# Desconecta el daemon
mysqladmin shutdown -uroot -p"${MYSQL_ROOT_PASSWORD}"

# Arranca el daemon de forma normal
exec mysqld --bind-address=0.0.0.0
