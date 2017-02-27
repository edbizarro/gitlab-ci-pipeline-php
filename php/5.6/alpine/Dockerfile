FROM php:5.6-alpine

LABEL maintainer="Eduardo Bizarro <eduardo@zendev.com.br>"
LABEL php "7.0"

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
    g++ \
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

# PHP Extensions
RUN docker-php-ext-configure imap --with-imap --with-imap-ssl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
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

# NODE

ENV VERSION=v7.6.0 NPM_VERSION=4

# For base builds
# ENV CONFIG_FLAGS="--fully-static --without-npm" DEL_PKGS="libstdc++" RM_DIRS=/usr/include

RUN apk add --no-cache python linux-headers binutils-gold gnupg libstdc++ && \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys \
      9554F04D7259F04124DE6B476D5A82AC7E37093B \
      94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
      0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
      FD3A5288F042B6850C66B31F09FE44734EB7990E \
      71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
      DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
      C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
      B9AE9905FFD7803F25714661B63B535A4C206CA9 && \
    curl -sSLO https://nodejs.org/dist/${VERSION}/node-${VERSION}.tar.xz && \
    curl -sSL https://nodejs.org/dist/${VERSION}/SHASUMS256.txt.asc | gpg --batch --decrypt | \
      grep " node-${VERSION}.tar.xz\$" | sha256sum -c | grep . && \
    tar -xf node-${VERSION}.tar.xz && \
    cd node-${VERSION} && \
    ./configure --prefix=/usr ${CONFIG_FLAGS} && \
    make -j$(getconf _NPROCESSORS_ONLN) && \
    make install && \
    cd / && \
    if [ -x /usr/bin/npm ]; then \
      npm install -g npm@${NPM_VERSION} && \
      find /usr/lib/node_modules/npm -name test -o -name .bin -type d | xargs rm -rf; \
    fi && \
    apk del curl make gcc g++ python linux-headers binutils-gold gnupg ${DEL_PKGS} && \
    rm -rf ${RM_DIRS} /node-${VERSION}* /usr/share/man /tmp/* /var/cache/apk/* \
      /root/.npm /root/.node-gyp /root/.gnupg /usr/lib/node_modules/npm/man \
      /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html /usr/lib/node_modules/npm/scripts

RUN apk del --purge \
		.build-deps \
		autoconf \
		gcc \
		make \
		g++ \
		file \
		pkgconf \
		build-base \
		libtool \
		wget \
		sed \
		grep \
    libltdl \
		&& rm -rf /var/cache/apk/* /tmp/* /usr/share/man
