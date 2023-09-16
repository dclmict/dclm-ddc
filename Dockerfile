FROM opeoniye/nginx

# working directory
WORKDIR /var/www

# copy code
COPY --chown=www:www-data ./src /var/www