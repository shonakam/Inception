# https://hub.docker.com/_/alpine
FROM alpine:3.21.4

RUN apk update && apk add --no-cache \
        nginx

COPY ./conf.d/default.conf /etc/nginx/http.d/default.conf 

COPY ./tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

EXPOSE 80 443

ENTRYPOINT [ "/setup.sh" ]
