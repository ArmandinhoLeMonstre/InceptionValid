FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	php php-fpm php-mysql php-curl php-xml php-mbstring \
	mariadb-client \
	curl wget unzip \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html \
    && curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xzf wordpress.tar.gz -C /var/www/html --strip-components=1 \
    && rm wordpress.tar.gz

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp


COPY tools/init_wordpress.sh /usr/local/bin/init_wordpress.sh
RUN chmod +x /usr/local/bin/init_wordpress.sh

EXPOSE 9000

ENTRYPOINT ["init_wordpress.sh"]

