#!/bin/bash

apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    libmcrypt-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
    libgmp-dev \
    libssl-dev \
    libicu-dev \
    libbz2-dev \
    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        bz2 \
        gd \
        gmp \
        imap \
        intl \
        mbstring \
        mcrypt \
        opcache \
        pdo_mysql \
        zip

# MONGO, xdebug and other extensions
pecl install redis mongodb xdebug-2.5.1 apcu \
  && docker-php-ext-enable redis mongodb xdebug apcu
