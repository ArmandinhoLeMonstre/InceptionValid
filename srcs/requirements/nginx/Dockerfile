FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl /var/www/html /run/nginx

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/C=BE/ST=Bruxelles/L=Bruxelles/O=42/OU=armitite/CN=armitite.42.fr" \
    -keyout /etc/nginx/ssl/cert.key \
    -out /etc/nginx/ssl/cert.crt

COPY conf/default.conf /etc/nginx/sites-available/default

RUN chmod -R 755 /etc/nginx /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

