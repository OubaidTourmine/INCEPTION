#!/bin/bash

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(sed -n '1p' /run/secrets/credentials)
WP_USER_PASSWORD=$(sed -n '2p' /run/secrets/credentials)

mkdir -p /var/www/wordpress
cd /var/www/wordpress

if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

if [ ! -f wp-config.php ]; then
    wp core download --allow-root

    mv /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php

    sed -i "s/define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', '${MYSQL_DATABASE}' );/" wp-config.php
    sed -i "s/define( 'DB_USER', 'username_here' );/define( 'DB_USER', '${MYSQL_USER}' );/" wp-config.php
    sed -i "s/define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', '${MYSQL_PASSWORD}' );/" wp-config.php
    sed -i "s/mariadb/mariadb/" wp-config.php
