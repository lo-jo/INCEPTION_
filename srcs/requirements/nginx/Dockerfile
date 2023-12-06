#base OS image to use as starting point for building the docker image
FROM	debian:bookworm

#executing commands in the terminal of the container
RUN	apt update
RUN	apt upgrade
RUN	apt install nginx -y

#installation de opensll pour la creation de certificats ssl
RUN	apt install openssl -y 
#stocker certificat et clef pour connexion tsl securisee
RUN	mkdir -p /etc/nginx/ssl
#creates a folder where to store nginx config files
RUN mkdir -p /var/run/nginx
RUN mkdir -p /var/www/wordpress

#certificates / protocol -x509 is the certificate type /
RUN	openssl req -x509 -nodes \
    -out /etc/nginx/ssl/ljospin.42.fr.crt \
    -keyout /etc/nginx/ssl/ljospin.42.fr.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42, Inc./OU=IT/CN=ljospin.42.fr"

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/sites-enabled/default.conf

RUN	chmod 755 /var/www/html
#main user
RUN chown -R www-data:www-data /var/www/html
RUN chown -R www-data:www-data /var/log/nginx/

#exposed port
EXPOSE	443

#deactivate daemon mode - nginx is executing in the foreground
CMD ["nginx", "-g", "daemon off;"]

