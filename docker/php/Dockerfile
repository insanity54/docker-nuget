FROM php:5-fpm-alpine

ENV APP_BASE /var/www/html

# Install php extensions needed by simple-nuget-server
RUN docker-php-ext-install pdo_mysql && \
    docker-php-ext-enable pdo_mysql

# Configure php so it will daemonize instead of running in CLI mode (not needed, happens by default in php:5-fpm-alpine)
#RUN sed 's!daemonize = no!daemonize = yes!g' /usr/local/etc/php-fpm.d/docker.conf

# Copy in the project
COPY simple-nuget-server $APP_BASE
RUN rm -rf $APP_BASE/.git && \
    chown 0770 $APP_BASE/db $APP_BASE/packagefiles

# Set randomly generated API key
RUN echo $(date +%s | sha256sum | base64 | head -c 32; echo) > $APP_BASE/.api-key
RUN echo "Auto-Generated NuGet API key: $(cat $APP_BASE/.api-key)"
RUN sed -i $APP_BASE/inc/config.php -e "s!ChangeThisKey!$(cat $APP_BASE/.api-key)!"

# Set URL, usernames & passwords to mysql server
RUN sed -i $APP_BASE/inc/config.php -e "s!sqlite:../db/packages.sqlite3!mysql:host=mysql;dbname=sns!"
RUN echo "Config::\$dbUsername = 'nuget';"     >> $APP_BASE/inc/config.php
RUN echo "Config::\$dbPassword = 'changeme';"  >> $APP_BASE/inc/config.php # @todo dynamically set this based on mysql env var configured in docker-compose.yml