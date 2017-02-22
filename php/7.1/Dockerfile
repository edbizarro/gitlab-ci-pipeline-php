FROM php:7.1

LABEL maintainer "Eduardo Bizarro <eduardo@zendev.com.br>"
LABEL architecture "amd64"
LABEL php "7.1"
LABEL node "7"

# Set correct environment variables
ENV HOME="/root" \
    PATH="~/.yarn/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

RUN apt-get update && \
    apt-get install -yqq \
    git \
    curl \
    openssl \
    openssh-client \
    --no-install-recommends

# PHP Extensions
RUN apt-get update && apt-get install -y \
    libmcrypt-dev \
    libxml2-dev \
    libcurl4-gnutls-dev \
    mcrypt \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
    libssl-dev \
    libicu-dev \
    libbz2-dev \
    libc-client-dev \
    libkrb5-dev \
    zlib1g-dev \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) \
    gd \
    curl \
    mcrypt \
    json \
    xml \
    mbstring \
    pdo \
    pdo_mysql \
    iconv \
    opcache \
    intl \
    zip \
    bz2 \
    bcmath

# MONGO extension
RUN pecl install mongodb \
    && echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongo.ini

# Run xdebug installation.
RUN pecl install xdebug-2.5.0 \
    && docker-php-ext-enable xdebug

VOLUME /root/composer

# Environmental Variables
ENV COMPOSER_HOME /root/composer

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install hirak/prestissimo to speedup composer installs.
RUN composer global require hirak/prestissimo --prefer-dist --no-interaction && \
    rm -rf /root/.composer/cache/*

# NODE JS
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
    DEBIAN_FRONTEND=noninteractive apt-get install nodejs --no-install-recommends -yqq && \
    npm install -g gulp

# YARN
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

RUN apt-get autoclean -y \
    && apt-get --purge autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
