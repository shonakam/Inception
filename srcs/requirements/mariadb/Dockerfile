# https://hub.docker.com/_/alpine
FROM alpine:3.21.4

RUN apk update && apk add --no-cache \
        mariadb \
        mariadb-client \
        procps

COPY ./conf/init.sql /init.sql
COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/setup.sh /setup.sh

RUN chmod +x /setup.sh

EXPOSE 3306

ENTRYPOINT ["/setup.sh"]
