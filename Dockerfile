#Download base image ubuntu 16.04
FROM ubuntu:16.04

# Update Ubuntu Software repository
RUN apt-get update

# Install nginx, php-fpm and supervisord from ubuntu repository
RUN apt-get install -y nginx php7.0-fpm supervisor tcpdump net-tools git wget bundler && \
    rm -rf /var/lib/apt/lists/*

#Install and configure fluentd server
RUN  cd /opt/ &&\
     git clone git://github.com/kazegusuri/fluent-plugin-prometheus &&\
     cd fluent-plugin-prometheus &&\
     wget https://github.com/prometheus/prometheus/releases/download/v1.5.2/prometheus-1.5.2.linux-amd64.tar.gz &&\
     tar -xzvf prometheus-1.5.2.linux-amd64.tar.gz &&\
     bundle install --path vendor/bundle &&\
     echo "about to set up ENV variables ..."

#Define the ENV variable
ENV nginx_vhost /etc/nginx/sites-available/default
ENV php_conf /etc/php/7.0/fpm/php.ini
ENV nginx_conf /etc/nginx/nginx.conf
ENV supervisor_conf /etc/supervisor/supervisord.conf

# Enable php-fpm on nginx virtualhost configuration
COPY default ${nginx_vhost}
RUN sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${php_conf} && \
    echo "\ndaemon off;" >> ${nginx_conf}

#Copy supervisor configuration
COPY supervisord.conf ${supervisor_conf}
COPY nginx_proxy.conf /etc/nginx/sites-enabled/

RUN mkdir -p /run/php && \
    chown -R www-data:www-data /var/www/html && \
    chown -R www-data:www-data /run/php

# Configure Services and Port
COPY start.sh /start.sh
CMD ["./start.sh"]

EXPOSE 80 443 9999 24231 9090
