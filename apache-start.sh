#!/bin/bash
#https://wiki.debian.org/WordPress
#variabile
WORDPRESS_PTH=/opt/wpress/src
#fissa e uguale a virtual host
FOLDER_WEB=html





#Check if MediaWiki is already installed by check folder
if [ -e "/var/wpress/${FOLDER_WEB}" ];
then
	echo "Wpress is already installed"
else

	mkdir /var/wpress
	ln -s ${WORDPRESS_PTH} /var/wpress/${FOLDER_WEB}
	#ln -s /opt/wpress/src/Search-Replace-DB-master /var/www/html/

	#Change permission on images folder
	chmod -R 544 /var/wpress/${FOLDER_WEB}
	chmod 755 /var/wpress/${FOLDER_WEB}
	#chmod -R 755 /var/www/html/Search-Replace-DB-master
	#chown -R www-data:www-data /var/www/html/Search-Replace-DB-master
	chown -R www-data:www-data /var/wpress/${FOLDER_WEB}
	chown -R www-data:www-data ${WORDPRESS_PTH}
	chmod -R 755 ${WORDPRESS_PTH}
	#Enable module
	service apache2 restart && service apache2 stop
	#/opt/semantic-platform/database/mysql/load.sh
	
	##--skip-external-dependencies per non usare compoeser se si aggiunge
	#configurazione estensioni
	#apt-get update && apt-get install -y apt-utils libpng12-dev netcat wget unzip vim php-pear
	ln -s /usr/bin/pear /usr/share/pear

	# Wait for the DB to come up
	#while [ `/bin/nc -w 1 $MEDIAWIKI_DB_HOST $MEDIAWIKI_DB_PORT < /dev/null > /dev/null; echo $?` != 0 ]; do
	#    echo >&2 "INFO: In attesa che il database sia disponibile $MEDIAWIKI_DB_HOST:$MEDIAWIKI_DB_PORT..."
	#    sleep 1
	#done
    #echo >&2 "INFO: Database $MEDIAWIKI_DB_HOST:$MEDIAWIKI_DB_PORT disponibile"
	echo "finish Conf Apache"
fi

#Launch apache2 foreground mode
/usr/sbin/apache2ctl -D FOREGROUND
