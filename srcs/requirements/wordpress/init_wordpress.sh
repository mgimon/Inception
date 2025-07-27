#!/bin/bash

# Protection
set -e

# mariadb. ping --silent returns 0 (true) when ready
until mysqladmin ping -h"$DB_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
  sleep 2
done

cd /var/www/html

##### wp-cli.phar = wp #####

# wp core download
if [ ! -f wp-load.php ]; then
  wp core download --allow-root
fi

# wp-config.php
if [ ! -f wp-config.php ]; then
  wp config create \
    --dbname="$MYSQL_DATABASE" \
    --dbuser="$MYSQL_USER" \
    --dbpass="$MYSQL_PASSWORD" \
    --dbhost="$DB_HOST" \
    --skip-check \
    --allow-root
fi

# wp core
if ! wp core is-installed --allow-root; then
  wp core install \
    --url="$WP_URL" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --skip-email \
    --allow-root
fi

wp user create "$WP_USER" "$WP_USER_EMAIL" \
  --role=subscriber \
  --user_pass="$WP_USER_PASSWORD" \
  --allow-root || true

# php-fpm listens to 9000 (nginx php requests)
sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

# permisos a usuario de php-fpm sobre www/html
chown -R www-data:www-data /var/www/html

# execute php-fpm (main process)
exec php-fpm7.4 -F
