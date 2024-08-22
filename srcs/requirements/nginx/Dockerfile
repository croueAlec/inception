FROM debian:bullseye

# Install Nginx
RUN apt update
RUN apt install -y nginx

# Install tools
RUN apt install -y \
    	vim \
		curl

# Setup self-signed certificate
RUN apt install -y openssl
RUN apt clean
RUN mkdir -p /etc/nginx/ssl
RUN openssl req \
	-nodes \
	-new -x509 \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=acroue.42.fr/UID=acroue"

# Setup config
RUN mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY html/index.html /var/www/html/index.html
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]