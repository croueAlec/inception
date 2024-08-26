#!/bin/bash

# waiting for DB to be up
sleep 10

# checking if wordpress config already exists
if [ -f "wp-config.php" ]; then
    echo "Configuration already exists, exiting..."
    exit 0
else
    echo "Configurating wordpress"
fi

# creating wordpress config
wp config create	--allow-root \
                    --dbname=$SQL_DATABASE \
                    --dbuser=$SQL_USER \
                    --dbpass=$SQL_PASSWORD \
                    --dbhost=mariadb:3306 --path='/var/www/wordpress'

wp core install	--allow-root \
                --url=http://$DOMAIN_NAME \
                --title=$WP_TITLE \
                --admin_user=$WP_ADMIN_USER \
                --admin_password=$WP_ADMIN_PASS \
                --admin_email=$WP_ADMIN_EMAIL --path='/var/www/wordpress'

php-fpm7.4 -F