#!/bin/bash

# waiting for DB to be up
sleep 10

# checking if wordpress config already exists
if [ -f "wp-config.php" ]; then
    echo "Configuration already exists, exiting..."
    php-fpm7.4 -F
    exit 0
else
    echo "Configurating wordpress"
fi

# creating config
echo "wp config create"
wp config create	--allow-root \
                    --dbname=$SQL_DATABASE \
                    --dbuser=$SQL_USER \
                    --dbpass=$SQL_PASSWORD \
                    --dbhost=mariadb --path='/var/www/wordpress'

echo "wp core install"
wp core install	--allow-root \
                --url=http://$DOMAIN_NAME \
                --title=$WP_TITLE \
                --admin_user=$WP_ADMIN_USER \
                --admin_password=$WP_ADMIN_PASS \
                --admin_email=$WP_ADMIN_EMAIL --path='/var/www/wordpress'

echo "starting php"
php-fpm7.4 -F