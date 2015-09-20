FROM mocdk/supervisord
MAINTAINER Jan-Erik Revsbech <janerik@moc.net>

#Update Apt to have correct sources
COPY files/apt_sources.list /etc/apt/sources.list
RUN apt-get update

# Install apache and php
RUN apt-get install -y apache2 apache2-mpm-worker libapache2-mod-fastcgi php5-cli php5-fpm php5-gd php5-ldap php5-mysql php5-curl php5-sqlite php5-pgsql php5-imagick php5-mcrypt

# Install headers
RUN a2enmod actions
RUN a2enmod headers
RUN a2enmod rewrite
RUN a2enmod expires

# Enable fpm cgi handler
COPY files/fastcgi_phpfpm.conf /etc/apache2/mods-enabled/fastcgi_phpfpm.conf

# Set timezone correctly
RUN echo "date.timezone = Europe/Copenhagen" > /etc/php5/cli/conf.d/timezone.ini
RUN echo "date.timezone = Europe/Copenhagen" > /etc/php5/fpm/conf.d/timezone.ini

# Set memory limit for fpm process
RUN echo "memory_limit = 1G" > /etc/php5/cli/conf.d/memory.ini

### Remove default index.html file
#RUN rm /var/www/html/index.html

# Create a new PHP based index file
COPY files/index.php /var/www/html/index.php

#Copy supervisor files
COPY files/apache.conf /etc/supervisor/conf.d/apache.conf
COPY files/fpm.conf /etc/supervisor/conf.d/fpm.conf

EXPOSE 22 80
CMD ["/usr/bin/supervisord"]
