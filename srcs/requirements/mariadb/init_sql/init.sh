#!/bin/sh

if [ ! -d /var/lib/mysql/mysql ]; then
	mysql_install_db --datadir=/var/lib/mysql
	mysqld_safe & 
	sleep 2
	mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"
	echo "here"
	mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DB_NAME}\`;"
	
	echo "here22"
	mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS \`${MARIADB_ADMIN_USERNAME}\`@'localhost' IDENTIFIED BY '${MARIADB_ADMIN_PASSWORD}';"

	echo "here3"
	mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MARIADB_DB_NAME}\`.* TO \`${MARIADB_ADMIN_USERNAME}\`@'%' IDENTIFIED BY '${MARIADB_ADMIN_PASSWORD}';"
	
	echo "here4"
	mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -e "DROP DATABASE IF EXISTS test;"
	
	echo "here5"
	mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

	echo "here6"
	mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -e "SHOW VARIABLES WHERE Variable_name = 'hostname';"
	mysqladmin -u root -p"${MARIADB_ROOT_PASSWORD}" shutdown
	sleep 2
else 
	echo "MariaDB already set up"
fi
echo "here7"
exec mysqld;
