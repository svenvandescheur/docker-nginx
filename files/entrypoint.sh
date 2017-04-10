#!/bin/bash

# Docker entrypoint script
# Executes original command

# Summary:
# --------
# * Set up script
# * Start services
# * Execute command

# Set up script
set -e
set -o pipefail


# Create log directory
mkdir -p /var/log/nginx/

# Lets encryppt
apt-get -qy update
apt-get -qy install software-properties-common python-software-properties
add-apt-repository ppa:certbot/certbot -y
apt-get -qy update
apt-get -qy install certbot
apt-get -qy install python-certbot-nginx
certbot certonly --agree-tos --keep --noninteractive --standalone -d svenv.nl -d www.svenv.nl -d `hostname` -m svenvandescheur@gmail.com

# Start services
service rsyslog start
service cron start
service postfix start


# Execute command
if [[ $@ ]]
then
    exec "$@"
else
    service nginx start
fi
