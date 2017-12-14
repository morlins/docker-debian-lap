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
php-xcache \
php-curl \
imagemagick \
php-imagick \
wget \
git \
apt-utils \
libpng12-dev \
netcat \
wget \
unzip \
vim \
php-pear \

#Copy and run mediwiki start script
ADD apache-start.sh /opt
ADD conf/mime.conf /etc/apache2/conf-enabled
ADD conf/php.conf /etc/apache2/conf-enabled
ADD conf/site.conf /etc/apache2/sites-enabled
RUN chmod +x /opt/apache-start.sh
ENTRYPOINT ["/opt/apache-start.sh"]
#Ports
EXPOSE 80 443
