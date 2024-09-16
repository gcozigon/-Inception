#!/bin/bash

sleep 20

if [ -f wp-config.php ]; then
	echo "Wordpress Already Set-Up!"
else
	echo "Wordpress Not Set-Up yet"
	pwd	
	echo "Creating Wordpress Config..."
	wp config create --dbname=${MARIADB_DB_NAME}\
			 --dbuser=${MARIADB_ADMIN_USERNAME}\
			 --dbpass=${MARIADB_ADMIN_PASSWORD}\
			 --dbhost=mariadb:3306\
			 --dbcharset="utf8mb4"\
			 --dbcollate=''\
			 --allow-root;
	echo "Installing WordpressCore..."
	echo "Setting-Up Admin, Title, URL..."
	wp core install --url=${WORDPRESS_HTTPS_URL} \
	                --title=${WORDPRESS_TITLE_WEBSITE} --admin_user=${WORDPRESS_ADMIN} --admin_password=${WORDPRESS_PASS} --admin_email=${WORDPRESS_MAIL} --allow-root

	echo "Creating Author User..."
	wp user create ${WORDPRESS_AUTHOR_USERNAME} ${WORDPRESS_AUTHOR_MAIL} \
			--user_pass=${WORDPRESS_AUTHOR_PASS} \
        		--role=author\
			--allow-root;
	echo "Wordpress Set-Up Done!"
fi 

echo "Launching php-fpm, Wordpress is UP"
exec php-fpm7.4 -F
