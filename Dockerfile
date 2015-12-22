# Dockerfile for apache hosts with php5
#
# PHP modules:
#   - mysql
#
# Web data volume is exposed at /app/
#   The subdirectory /app/public will be exposed by the webserver
#   This allows private code (e.g password files) to be stored within
#   /app but not exposed to the public domain.
#
# Building:
#   docker build -t lsucs/apache-php .
#
FROM debian:jessie
MAINTAINER Matt Parker <mparker@lsucs.org.uk>
LABEL version="1.0"

# Install packages
RUN apt-get update \
  && apt-get -y install apache2 php5 php5-mysql \
  && apt-get clean 

# Environment
ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_SERVER_ADMIN webmaster@lsucs.org.uk
ENV APACHE_LOG_DIR /var/log/apache2

# Copy apache2.conf
ADD apache2.conf /etc/apache2/apache2.conf

# Ports http / https
EXPOSE 80
EXPOSE 443

# Launch apache
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
