FROM opeoniye/nginx

# working directory
WORKDIR /var/www

# copy code
COPY ./ops/docker/nginx/dtc.conf /etc/nginx/conf.d/default.conf
COPY --chown=www:www-data ./src /var/www