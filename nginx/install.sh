#!/bin/sh
#options: http://wiki.nginx.org/NginxInstallOptions
ROOT_PATH=$(dirname "$(cd "$(dirname "$0")"; pwd)")
apt-get install nginx
cp -rf ${ROOT_PATH}/nginx/nginx/* /etc/nginx/
