#!/bin/bash

# Protection
set -e

# Wait for mariadb. ping --silent returns 0 (true) when ready
until mysqladmin ping -h"$DB_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
  sleep 2
done

# Entering shared volume that NGINX can see
cd /var/www/html

# wp-cli.phar core download
if [ ! -f wp-load.php ]; then
  wp core download --allow-root
fi

# wp-cli.phar config create
if [ ! -f wp-config.php ]; then
  wp config create \
    --dbname="$MYSQL_DATABASE" \
    --dbuser="$MYSQL_USER" \
    --dbpass="$MYSQL_PASSWORD" \
    --dbhost="$DB_HOST" \
    --skip-check \
    --allow-root
fi

# wp-cli.phar core install
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

# execute php-fpm (main process)
exec php-fpm7.4 -F
