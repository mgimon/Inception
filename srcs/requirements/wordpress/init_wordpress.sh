#!/bin/bash

# Protection
set -e

# Entering shared volume that NGINX can see
cd /var/www/html

# WP core
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

# install WP
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

# execute main process in foreground
exec php-fpm7.3 -F
