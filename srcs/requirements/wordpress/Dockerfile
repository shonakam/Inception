# https://hub.docker.com/_/alpine
FROM alpine:3.21.4

RUN apk update && apk add --no-cache \
        php82 \
        php82-fpm \
        php82-mysqli \
        php82-json \
        php82-session \
        php82-phar \
        php82-tokenizer \
        php82-iconv \
        curl \
        mysql-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN ln -sf /usr/bin/php82 /usr/local/bin/php

COPY conf/www.conf /etc/php82/php-fpm.d/www.conf
COPY wordpress.tar.gz /wordpress.tar.gz

RUN mkdir -p /var/www/html && \
        tar -xvzf /wordpress.tar.gz && \
        mv /wordpress/* /var/www/html

COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

EXPOSE 9000

ENTRYPOINT [ "/setup.sh" ]
# CMD ["php-fpm8.2", "-F"]
