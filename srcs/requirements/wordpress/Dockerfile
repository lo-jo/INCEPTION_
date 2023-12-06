FROM	debian:bookworm

RUN	apt update
RUN	apt upgrade
RUN apt install wget -y
#RUN apt install software-properties-common -y
#RUN add-apt-repository ppa:ondrej/php

RUN apt install php8.2 php-fpm php-mysql mariadb-client -y
RUN wget https://fr.wordpress.org/wordpress-6.4.1-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.4.1-fr_FR.tar.gz && rm wordpress-6.4.1-fr_FR.tar.gz
RUN chown -R root:root /var/www/wordpress

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
#RUN a2enmod proxy_fcgi setenvif
#RUN a2enconf php8.2-fpm
#run next commands inside the var/www/wordpress file to avoid install conflicts
WORKDIR /var/www/wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# make it executable
RUN chmod +x wp-cli.phar
# move it to local/usr/bin so it can be run directly
RUN mv wp-cli.phar /usr/local/bin/wp

COPY tools/entrypoint.sh .
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
