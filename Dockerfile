#On choisit Debian
FROM debian:9

MAINTAINER gmorlini "gmorlini@imolinfo.it"

#Ne pas poser de question à l'installation
ENV DEBIAN_FRONTEND noninteractive

RUN apt update \
&& apt -y install \
apache2 \
php \
php-mysql \
php-ldap \
php-curl \
imagemagick \
php-imagick \
wget \
git \
apt-utils \
netcat \
telnet \
wget \
unzip \
vim \
php-pear \
php-opcache \
libapache2-mod-php \
php-mbstring \
php-gd

RUN a2enmod rewrite && a2enmod headers && a2enmod mime && a2enmod mime_magic && a2enmod ssl && service apache2 restart 
#php-xcache \ -> zend opcahce TODO && a2enmod php
#Copy and run mediwiki start script
ADD apache-start.sh /opt
ADD conf/mime.conf /etc/apache2/conf-enabled
#ADD conf/php.conf /etc/apache2/conf-enabled
ADD conf/site.conf /etc/apache2/sites-enabled
RUN mkdir /opt/cert
ADD conf/cert/httpdocker.crt /opt/cert/httpdocker.crt
ADD conf/cert/httpdocker.key /opt/cert/httpdocker.key
RUN chmod +x /opt/apache-start.sh
ENTRYPOINT ["/opt/apache-start.sh"]
#Ports
EXPOSE 80 443
