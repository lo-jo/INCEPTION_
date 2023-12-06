#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

	#Restarting mariadb service to avoid socket conflicts
	service mariadb restart
	#/etc/init.d/mariadb restart
	
	echo -e "${GREEN}MYSQL RESTARTED ${ENDCOLOR}"

	#DEBUGGING : checking if mariadb is active and running
	#/etc/init.d/mariadb status
	#/usr/bin/mariadb-admin ping
	echo -e "${GREEN}LOGGING AS ROOT${ENDCOLOR}"
	mariadb -u root -p$DB_ADMIN_PW;
	sleep 2
	echo -e "${GREEN}CREATING DATABASE NAME${ENDCOLOR}"
	mariadb -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
	
	echo -e "${GREEN}CREATING DATABASE ADMINISTRATOR${ENDCOLOR}"
	mariadb -e "CREATE USER IF NOT EXISTS '$DB_ADMIN'@'localhost' \
		IDENTIFIED BY '$DB_ADMIN_PW';"
	mariadb -e "GRANT ALL PRIVILEGES ON DB_DATA_BASE_NAME.* TO '$DB_ADMIN@test'\
		IDENTIFIED BY '$DB_ADMIN_PW' WITH GRANT OPTION;"
	echo -e "${GREEN}Applying changes...${ENDCOLOR}"
	mariadb -e "FLUSH PRIVILEGES;"
	
	echo -e "${GREEN}CREATING DATABASE USER${ENDCOLOR}"
	mariadb -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' \
		IDENTIFIED BY '$DB_USER_PW';"
	mariadb -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%'\
		IDENTIFIED BY '$DB_USER_PW';"
	echo -e "${GREEN}Applying changes...${ENDCOLOR}"
	mariadb -e "FLUSH PRIVILEGES;"
	sleep 3
	echo -e "${GREEN}DATABASE CREATED. NOW STARTING THE MARIADB DEAMON.${ENDCOLOR}"
	if pgrep -x "mysqld_safe" >/dev/null; then
   		echo "MySQL server processes are already running. "
   		service mariadb stop
		exec mysqld_safe
		
	else
		exec mysqld_safe
	fi


