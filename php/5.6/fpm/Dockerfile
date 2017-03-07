FROM php:5.6-fpm

LABEL maintainer "Eduardo Bizarro <eduardo@zendev.com.br>" \
      php="5.6" \
      node="7"

# Set correct environment variables
ENV HOME="/root" \
    PATH="~/.yarn/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
    COMPOSER_HOME="/root/composer"

WORKDIR /tmp

# COPY INSTALL SCRIPTS
COPY ./php/scripts/*.sh /tmp/
RUN chmod +x /tmp/*.sh

# Install
RUN bash ./packages.sh \
    &&  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
        $RUNTIME_PACKAGES \
        && docker-php-ext-configure imap --with-kerberos --with-imap --with-imap-ssl \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) \
        imap \
        gd \
        mcrypt \
        mbstring \
        pdo_mysql \
        opcache \
        intl \
        zip \
        bz2 \
        bcmath \
        # MONGO, xdebug and other extensions
        && pecl install mongodb xdebug-2.5.0 apcu-4.0.11 \
        && docker-php-ext-enable mongodb xdebug apcu \
    && bash ./composer.sh \
    && bash ./node.sh \
    && bash ./cleanup.sh

WORKDIR /root
