FROM php:7.1-alpine

LABEL maintainer "Eduardo Bizarro <eduardo@zendev.com.br>"
LABEL architecture "amd64"
LABEL php "7.1"

# Set correct environment variables
ENV HOME="/root" \
    PATH="~/.yarn/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

RUN apk add --update --no-cache \
		ca-certificates \
		openssl \
		autoconf \
		gcc \
		make \
		bash \
		sed \
		grep \
    zlib-dev \
		file \
		libc-dev \
		make \
		pkgconf \
		tar \
    libmcrypt-dev \
    libxml2-dev \
    libxml2 \
		openssh \
		openssh-client \
    autoconf \
    g++

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

# YARN
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

RUN apk del --purge \
		.build-deps \
		autoconf \
		gcc \
		make \
		g++ \
		file \
		pkgconf \
		*-dev \
		build-base \
		libtool \
		wget \
		sed \
		grep \
		&& rm -rf /var/cache/apk/* /tmp/* /usr/share/man
