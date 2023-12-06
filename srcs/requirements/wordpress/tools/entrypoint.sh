#!/bin/bash

sleep 10

if [ ! -f /var/wwww/wordpress/wp-config.php ];

then 
	echo "CREATING WORDPRESS CONFIG"
	wp config create --allow-root \
	       --dbname=$DB_NAME \
	       --dbuser=$DB_USER \
	       --dbpass=$DB_USER_PW \
	       --dbcharset="utf8" \
	       --dbhost=mariadb:3306 --path='/var/www/wordpress'

    sleep 2
	echo "CREATING WORDPRESS BASIC INFOS"
	wp core install --allow-root \
		--url=$SITE_URL \
		--title=$SITE_TITLE \
		--admin_user=$ADMIN_USER \
		--admin_password=$ADMIN_PASSWORD \
		--admin_email=$ADMIN_EMAIL \
		--allow-root \
		--path='/var/www/wordpress'

	wp user create --allow-root \
		--role=author \
        $USER_NAME \
        $USER_EMAIL \
		--user_pass=$USER_PASS \
		--path='/var/www/wordpress'

fi

if [ ! -d /run/php ];

then
	echo "creating /run/php directory"
	mkdir /run/php;

fi
echo "running php-fpm"
/usr/sbin/php-fpm8.2 -F
