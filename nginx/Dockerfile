FROM nginx:latest

RUN apt-get update

RUN mkdir -p /var/www/html

ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./default.conf /etc/nginx/conf.d/