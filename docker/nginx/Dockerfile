FROM nginx:alpine

COPY ./src/public /var/www/public
COPY ./docker/nginx/default.conf.template /etc/nginx/templates/default.conf.template

WORKDIR /var/www/public