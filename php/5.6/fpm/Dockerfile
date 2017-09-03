FROM php:5.6-fpm

LABEL maintainer "Eduardo Bizarro <eduardo@zendev.com.br>" \
      php="5.6" \
      node="8"

# Set correct environment variables
ENV HOME="/root" \
    COMPOSER_HOME=$HOME/composer

ENV PATH $HOME/.yarn/bin:$PATH

WORKDIR /tmp

# COPY INSTALL SCRIPTS
COPY ./php/scripts/*.sh /tmp/
RUN chmod +x /tmp/*.sh

# Install
RUN bash ./packages.sh \
    &&  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
        libmcrypt-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        libssl-dev \
        libicu-dev \
        libbz2-dev \
        && docker-php-ext-configure imap --with-kerberos --with-imap --with-imap-ssl \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) \
          bcmath \
          bz2 \
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
          pdo_mysql \
          soap \
          xml \
          xmlrpc \
          zip \
        # MONGO, xdebug and other extensions
        && pecl install mongodb xdebug-2.5.0 apcu-4.0.11 \
        && docker-php-ext-enable mongodb xdebug apcu \
    && bash ./composer.sh \
    && bash ./node.sh \
    && bash ./cleanup.sh

WORKDIR /root
