FROM debian:bullseye

# Install wordpress
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
		wget
RUN wget https://wordpress.org/wordpress-6.6.1.tar.gz -P /var/www
WORKDIR /var/www
RUN tar -xvf wordpress-6.6.1.tar.gz && rm wordpress-6.6.1.tar.gz
RUN chmod -R 755 /var/www/wordpress && \
	chown -R root:root /var/www/wordpress

# Install and configure Php
RUN apt-get update && apt-get upgrade && apt-get install -y \
		php \
		php7.4-fpm \
		php-mysql \
		mariadb-client
RUN apt-get clean
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/
RUN mkdir -p /run/php

# Configure wordpress
WORKDIR /var/www/wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
COPY tools/wordpress_config.sh /usr/local/bin/.
RUN chmod +x /usr/local/bin/wordpress_config.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress_config.sh"]