#!/bin/bash
set -e

SSL_DIR="/etc/nginx/ssl"
mkdir -p "$SSL_DIR"

openssl req -x509 -nodes -days 365 \
    -subj "/C=BE/ST=Bruxelles/L=Bruxelles/O=42/OU=armitite/CN=armitite.42.fr" \
    -newkey rsa:2048 \
    -keyout "$SSL_DIR/cert.key" \
    -out "$SSL_DIR/cert.crt"

