#!/bin/sh

ROOT_PATH=$(dirname "$(cd "$(dirname "$0")"; pwd)")
apt-get install php5-cli php5-cgi php5-mysql
apt-get install spawn-fcgi
cp ${ROOT_PATH}/php/php-cgi.conf /etc/default/php-cgi
cp ${ROOT_PATH}/php/php-cgi /etc/init.d/php-cgi
chmod +x /etc/init.d/php-cgi
update-rc.d php-cgi defaults
service php-cgi start
