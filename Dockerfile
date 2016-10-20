FROM svenv/base
MAINTAINER Sven van de Scheur <svenvandescheur@gmail.com>

# Add nginx key
RUN wget -q -O- http://nginx.org/keys/nginx_signing.key | apt-key add -

# Install required packages
RUN apt-get update && apt-get install -y \
    nginx

# Add file tree
ADD files /

# Expose
EXPOSE 80 443