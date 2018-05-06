#!/bin/bash

set -euf -o pipefail

apk --update --no-cache add \
  zlib-dev \
  libbz2 \
  libxml2-dev \
  imap-dev \
  freetype-dev \
  libjpeg-turbo-dev \
  libltdl \
  libtool \
  libedit-dev \
  libpng-dev \
  krb5-dev \
  icu-dev \
  readline-dev \
  bzip2 \
  bzip2-dev \
  curl-dev \
  libxslt-dev \
  imagemagick-dev \
  imagemagick \
  gmp-dev \
  postgresql-dev \
  libintl \
  pcre-dev \
  sqlite-dev \
  cyrus-sasl-dev \
  libmemcached-dev \
  openldap-dev

docker-php-ext-configure ldap
docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) ldap
docker-php-ext-configure imap --with-kerberos --with-imap-ssl
docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) imap
docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) gd
docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) exif xml xmlrpc pcntl bcmath bz2 calendar iconv intl mbstring mysqli opcache pdo_mysql pdo_pgsql pgsql soap zip
docker-php-source delete


pecl install xdebug \
  && docker-php-ext-enable xdebug

if [[ $PHP_VERSION =~ "7.2" ]]; then
  git clone --depth 1 "https://github.com/xdebug/xdebug" \
    && cd xdebug \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && docker-php-ext-enable xdebug
else
  apk --update --no-cache add \
    libmcrypt-dev \
    libmcrypt \

    docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) mcrypt
fi

docker-php-source extract \
    && curl -L -o /tmp/redis.tar.gz "https://github.com/phpredis/phpredis/archive/3.1.6.tar.gz" \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-3.1.6 /usr/src/php/ext/redis \
    && docker-php-ext-install redis \
    && docker-php-source delete

docker-php-source extract \
    && apk add --no-cache --virtual .phpize-deps-configure $PHPIZE_DEPS \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && apk del .phpize-deps-configure \
    && docker-php-source delete

pecl install imagick \
    && docker-php-ext-enable imagick

pecl install mongodb \
    && docker-php-ext-enable mongodb

git clone "https://github.com/php-memcached-dev/php-memcached.git" \
    && cd php-memcached \
    && phpize \
    && ./configure --disable-memcached-sasl \
    && make \
    && make install \
    && cd ../ && rm -rf php-memcached \
    && docker-php-ext-enable memcached

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
