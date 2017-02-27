#!/bin/bash

apk add --update --no-cache \
    ca-certificates \
    openssl \
    autoconf \
    gcc \
    g++ \
    make \
    sed \
    grep \
    zlib-dev \
    file \
    libc-dev \
    pkgconf \
    tar \
    openssh-client \
    autoconf \
    libmcrypt-dev \
    libxml2-dev \
    freetype-dev \
    libjpeg-turbo-dev \
    libltdl \
    libmcrypt-dev \
    libpng-dev \
    imap-dev \
    openssl-dev \
    curl-dev \
    icu-dev \
    bzip2-dev

docker-php-ext-configure imap --with-imap --with-imap-ssl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) \
      imap \
      gd \
      mcrypt \
      mbstring \
      pdo_mysql \
      opcache \
      intl \
      zip \
      bz2 \
      bcmath

pecl install xdebug-2.5.0 mongodb \
    && docker-php-ext-enable xdebug mongodb
