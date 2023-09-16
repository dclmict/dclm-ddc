FROM opeoniye/nginx

# working directory
WORKDIR /var/www

# copy code
COPY --chown=nginx:nginx ./src /var/www

# run user as node
USER nginx