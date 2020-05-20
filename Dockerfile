#
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
#
FROM phusion/baseimage

RUN DEBIAN_FRONTEND=noninteractive
RUN locale-gen en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm

# Add the "PHP" ppa
RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ondrej/php

#
#--------------------------------------------------------------------------
# Software's Installation
#--------------------------------------------------------------------------
#

RUN echo 'DPkg::options { "--force-confdef"; };' >> /etc/apt/apt.conf

# Install "PHP 5.6 Extentions", "libraries", "Software's"
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --allow-downgrades --allow-remove-essential \
    --allow-change-held-packages \
    php5.6-cli \
    php5.6-common \
    php5.6-curl \
    php5.6-intl \
    php5.6-json \
    php5.6-xml \
    php5.6-mbstring \
    php5.6-mcrypt \
    php5.6-mysql \
    php5.6-pgsql \
    php5.6-sqlite \
    php5.6-sqlite3 \
    php5.6-zip \
    php5.6-bcmath \
    php5.6-memcached \
    php5.6-gd \
    php5.6-dev \
    pkg-config \
    libcurl4-openssl-dev \
    libedit-dev \
    libssl-dev \
    libxml2-dev \
    xz-utils \
    libsqlite3-dev \
    sqlite3 \
    git \
    curl \
    vim \
    nano \
    postgresql-client \
    && apt-get clean

# Install "PHP 7.0 Extentions", "libraries", "Software's"
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --allow-downgrades --allow-remove-essential \
    --allow-change-held-packages \
    php7.0-cli \
    php7.0-common \
    php7.0-curl \
    php7.0-intl \
    php7.0-json \
    php7.0-xml \
    php7.0-mbstring \
    php7.0-mcrypt \
    php7.0-mysql \
    php7.0-pgsql \
    php7.0-sqlite \
    php7.0-sqlite3 \
    php7.0-zip \
    php7.0-bcmath \
    php7.0-memcached \
    php7.0-gd \
    php7.0-dev \
    && apt-get clean

# Install "PHP 7.1 Extentions", "libraries", "Software's"
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --allow-downgrades --allow-remove-essential \
    --allow-change-held-packages \
    php7.1-cli \
    php7.1-common \
    php7.1-curl \
    php7.1-intl \
    php7.1-json \
    php7.1-xml \
    php7.1-mbstring \
    php7.1-mcrypt \
    php7.1-mysql \
    php7.1-pgsql \
    php7.1-sqlite \
    php7.1-sqlite3 \
    php7.1-zip \
    php7.1-bcmath \
    php7.1-memcached \
    php7.1-gd \
    php7.1-dev \
    && apt-get clean

#####################################
# Composer:
#####################################

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

###########################################################################
# PHP REDIS EXTENSION
###########################################################################

RUN apt-get update -yqq && \
    apt-get install -yqq php-redis

###########################################################################
# Image optimizers:
###########################################################################

RUN apt-get install -y jpegoptim optipng pngquant gifsicle && \
    exec bash && . ~/.bashrc && npm install -g svgo

###########################################################################
# ImageMagick:
###########################################################################

RUN apt-get install -y imagemagick php-imagick

###########################################################################
# PYTHON:
###########################################################################

RUN apt-get -y install python python-pip python-dev build-essential  \
    && python -m pip install --upgrade pip

###########################################################################
# pgsql client
###########################################################################

RUN apt-get install wget \
    && add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && apt-get update \
    && apt-get -y install postgresql-client-10

###########################################################################
# ping:
###########################################################################

RUN apt-get update -yqq && \
    apt-get -y install inetutils-ping

###########################################################################
# Check PHP version:
###########################################################################

RUN set -xe; php5.6 -v | head -n 1 | grep -q "PHP 5.6."
RUN set -xe; php7.0 -v | head -n 1 | grep -q "PHP 7.0."
RUN set -xe; php7.1 -v | head -n 1 | grep -q "PHP 7.1."

USER root

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog
