# download base image ubuntu 16.10
FROM ubuntu:16.10
RUN apt-get update

#webserver
RUN apt-get -y install nginx

# configuring nginx to handle PHP
ADD conf/nginx /etc/nginx/sites-available/

# uploading source
WORKDIR /var/www/html
ADD output/html/ .

ENTRYPOINT nginx -g 'daemon off;'
