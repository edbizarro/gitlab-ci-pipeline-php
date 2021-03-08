#!/usr/bin/env bash

set -euo pipefail

apk --update --no-cache add \
  bzip2 \
  bzip2-dev \
  cassandra-cpp-driver \
  curl-dev \
  cyrus-sasl-dev \
  freetype-dev \
  gmp-dev \
  icu-dev \
  imagemagick \
  imagemagick-dev \
  imap-dev \
  krb5-dev \
  libbz2 \
  libedit-dev \
  libintl \
  libjpeg-turbo-dev \
  libltdl \
  libmemcached-dev \
  libpng-dev \
  libtool \
  libxml2-dev \
  libxslt-dev \
  openldap-dev \
  pcre-dev \
  postgresql-dev \
  rabbitmq-c \
  rabbitmq-c-dev \
  readline-dev \
  sqlite-dev \
  zlib-dev

apk --update --no-cache add libzip-dev libsodium-dev

if [[ $PHP_VERSION == "8.0" ]]; then
  docker-php-ext-configure ldap
  docker-php-ext-install -j "$(nproc)" ldap
  PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl
  docker-php-ext-install -j "$(nproc)" imap
  docker-php-ext-install -j "$(nproc)" exif pcntl bcmath bz2 calendar intl mysqli opcache pdo_mysql pdo_pgsql pgsql soap xsl zip gmp
  docker-php-source delete
else
  docker-php-ext-configure ldap
  docker-php-ext-install -j "$(nproc)" ldap
  PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl
  docker-php-ext-install -j "$(nproc)" imap
  docker-php-ext-install -j "$(nproc)" exif xmlrpc pcntl bcmath bz2 calendar intl mysqli opcache pdo_mysql pdo_pgsql pgsql soap xsl zip gmp
  docker-php-source delete
fi

if [[ $PHP_VERSION == "8.0" || $PHP_VERSION == "7.4" ]]; then
  docker-php-ext-configure gd --with-freetype --with-jpeg
else
  docker-php-ext-configure gd \
          --with-gd \
          --with-freetype-dir=/usr/include \
          --with-jpeg-dir=/usr/include \
          --with-png-dir=/usr/include
fi

docker-php-ext-install -j "$(nproc)" gd


git clone --depth 1 -b 3.0.2 "https://github.com/xdebug/xdebug" \
  && cd xdebug \
  && phpize \
  && ./configure \
  && make clean \
  && make \
  && make install \
  && docker-php-ext-enable xdebug

docker-php-source extract \
    && curl -L -o /tmp/redis.tar.gz "https://github.com/phpredis/phpredis/archive/5.3.3.tar.gz" \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-5.3.3 /usr/src/php/ext/redis \
    && docker-php-ext-install redis \
    && docker-php-source delete

docker-php-source extract \
    && apk add --no-cache --virtual .phpize-deps-configure $PHPIZE_DEPS \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && apk del .phpize-deps-configure \
    && docker-php-source delete

docker-php-source extract \
    && apk add --no-cache --virtual .cassandra-deps libressl-dev libuv-dev cassandra-cpp-driver-dev \
    && curl -L -o /tmp/cassandra.tar.gz "https://github.com/datastax/php-driver/archive/24d85d9f1d.tar.gz" \
    && mkdir /tmp/cassandra \
    && tar xfz /tmp/cassandra.tar.gz --strip 1 -C /tmp/cassandra \
    && rm -r /tmp/cassandra.tar.gz \
    && curl -L "https://github.com/datastax/php-driver/pull/135.patch" | patch -p1 -d /tmp/cassandra -i - \
    && mv /tmp/cassandra/ext /usr/src/php/ext/cassandra \
    && rm -rf /tmp/cassandra \
    && docker-php-ext-install cassandra \
    && apk del .cassandra-deps \
    && docker-php-source delete

if [[ $PHP_VERSION == "8.0" ]]; then
  #AMQP
  docker-php-source extract \
    && mkdir /usr/src/php/ext/amqp \
    && curl -L https://github.com/php-amqp/php-amqp/archive/master.tar.gz | tar -xzC /usr/src/php/ext/amqp --strip-components=1 \
    && docker-php-ext-install amqp \
    && docker-php-source delete

  #Imagick
  mkdir /usr/local/src \
    && cd /usr/local/src \
    && git clone https://github.com/Imagick/imagick \
    && cd imagick \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf imagick \
    && docker-php-ext-enable imagick

  #XMLRPC
  mkdir /usr/local/src/xmlrpc \
    && cd /usr/local/src/xmlrpc \
    && curl -L https://pecl.php.net/get/xmlrpc-1.0.0RC1.tgz | tar -xzC /usr/local/src/xmlrpc --strip-components=1 \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf xmlrpc \
    && docker-php-ext-enable xmlrpc

    pecl install mongodb \
      && docker-php-ext-enable mongodb
else
  pecl install amqp imagick mongodb \
    && docker-php-ext-enable amqp imagick mongodb
fi

git clone "https://github.com/php-memcached-dev/php-memcached.git" \
    && cd php-memcached \
    && phpize \
    && ./configure --disable-memcached-sasl \
    && make \
    && make install \
    && cd ../ && rm -rf php-memcached \
    && docker-php-ext-enable memcached

{ \
    echo 'opcache.enable=1'; \
    echo 'opcache.revalidate_freq=0'; \
    echo 'opcache.validate_timestamps=1'; \
    echo 'opcache.max_accelerated_files=10000'; \
    echo 'opcache.memory_consumption=192'; \
    echo 'opcache.max_wasted_percentage=10'; \
    echo 'opcache.interned_strings_buffer=16'; \
    echo 'opcache.fast_shutdown=1'; \
} > /usr/local/etc/php/conf.d/opcache-recommended.ini

{ \
    echo 'apc.shm_segments=1'; \
    echo 'apc.shm_size=512M'; \
    echo 'apc.num_files_hint=7000'; \
    echo 'apc.user_entries_hint=4096'; \
    echo 'apc.ttl=7200'; \
    echo 'apc.user_ttl=7200'; \
    echo 'apc.gc_ttl=3600'; \
    echo 'apc.max_file_size=50M'; \
    echo 'apc.stat=1'; \
} > /usr/local/etc/php/conf.d/apcu-recommended.ini

echo "memory_limit=1G" > /usr/local/etc/php/conf.d/zz-conf.ini

if [[ $PHP_VERSION == "8.0" || $PHP_VERSION == "7.4" ]]; then
  # https://xdebug.org/docs/upgrade_guide#changed-xdebug.coverage_enable
  echo 'xdebug.mode=coverage' > /usr/local/etc/php/conf.d/20-xdebug.ini
else
  echo 'xdebug.coverage_enable=1' > /usr/local/etc/php/conf.d/20-xdebug.ini
fi
