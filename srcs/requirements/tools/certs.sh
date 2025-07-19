#!/usr/bin/env bash

DOMAIN_NAME=shonakam.42.fr

mkdir -p srcs/.secrets/certs

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout srcs/.secrets/certs/${DOMAIN_NAME}.key \
    -out srcs/.secrets/certs/${DOMAIN_NAME}.crt \
    -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42School/OU=Inception/CN=${DOMAIN_NAME}"

echo "SSL証明書と秘密鍵が secrets/nginx_certs/ に生成されました。"
