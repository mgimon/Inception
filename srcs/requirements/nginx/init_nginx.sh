#!/bin/bash

# certificates
mkdir -p /etc/ssl/certs /etc/ssl/private

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
    openssl req -x509 -nodes -days 365 \
        -newkey rsa:4096 \
        -keyout /etc/ssl/private/nginx.key \
        -out /etc/ssl/certs/nginx.crt \
        -subj "/CN=mgimon-c.42.fr"
fi

# echo "configuracion de nginx en container:"
# cat /etc/nginx/conf.d/default.conf

# daemon off keeps nginx in foreground
exec nginx -g 'daemon off;'
