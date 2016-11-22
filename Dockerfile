FROM ubuntu:16.04
MAINTAINER Fer Uria <fauria@gmail.com>
LABEL Description="Search Replace DB tool Docker image" \
	License="GPL v3" \
	Usage="docker run -i -t --rm -p 8080:80 --link mysql-container:mysql fauria/srdb" \
	Version="1.0"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y php php-mysql php-mbstring apache2 libapache2-mod-php wget unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://github.com/interconnectit/Search-Replace-DB/archive/master.zip -P /var/www
RUN rm -rf /var/www/html
RUN unzip /var/www/master.zip -d /var/www
RUN mv /var/www/Search-Replace-DB-master /var/www/html
RUN chown -R www-data:www-data /var/www/html

VOLUME /var/www/html
EXPOSE 80

ENTRYPOINT ["/usr/sbin/apachectl", "-DFOREGROUND", "-k", "start"]
