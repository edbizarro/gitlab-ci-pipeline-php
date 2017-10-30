#!/bin/bash

apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    bzip2 \
    libbz2-dev \
    libcurl4-gnutls-dev \
    libfreetype6-dev \
    libgmp-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libpq-dev \
    libssl-dev \
    libxml2-dev \
    libkrb5-dev \
    libzip-dev \
    libmemcached-dev \
    libmagickwand-dev \
    imagemagick \
    libxslt1-dev \
    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        bz2 \
        calendar \
        curl \
        exif \
        gd \
        gmp \
        imap \
        intl \
        json \
        mbstring \
        mcrypt \
        opcache \
        pcntl \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        soap \
        xml \
        xmlrpc \
        xsl \
        zip

# MONGO, xdebug and other extensions
pecl channel-update pecl.php.net \
  && pecl install redis mongodb xdebug-2.5.5 apcu memcached imagick \
  && docker-php-ext-enable redis mongodb xdebug apcu memcached imagick

{ \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
} > /usr/local/etc/php/conf.d/opcache-recommended.ini

{ \
        echo 'apc.shm_segments=1'; \
        echo 'apc.shm_size=256M'; \
        echo 'apc.num_files_hint=7000'; \
        echo 'apc.user_entries_hint=4096'; \
        echo 'apc.ttl=7200'; \
        echo 'apc.user_ttl=7200'; \
        echo 'apc.gc_ttl=3600'; \
        echo 'apc.max_file_size=1M'; \
        echo 'apc.stat=1'; \
} > /usr/local/etc/php/conf.d/apcu-recommended.ini

echo "memory_limit=512M" > /usr/local/etc/php/conf.d/zz-conf.ini

cd /

docker-php-source delete
