FROM opeoniye/nginx

# working directory
WORKDIR /var/www

# copy code
COPY ./src /var/www