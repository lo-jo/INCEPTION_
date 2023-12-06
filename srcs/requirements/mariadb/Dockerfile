FROM debian:bookworm

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt install mariadb-server -y

#allow mysqld daemon to run, purge and recreate /var/lib/mysql with appropriate ownership
RUN mkdir -p /var/lib/mysql /run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql /run/mysqld && \
	chmod 777 /run/mysqld/

# Allow mariadb to communicate with wordpress in the network
RUN rm /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/entrypoint.sh .

RUN chmod +x ./entrypoint.sh 

#exposes the 3306 port (default port for MariaDB)
EXPOSE 3306

ENTRYPOINT ["./entrypoint.sh"]
