#!/usr/bin/env bash

set -euf -o pipefail

extensions=" \
bcmath \
bz2 \
calendar \
exif \
iconv \
intl \
mbstring \
mysqli \
opcache \
pcntl \
pdo_mysql \
pdo_pgsql \
pgsql \
soap \
xml \
xmlrpc \
zip
"

if [[ $PHP_VERSION == "7.3" || $PHP_VERSION == "7.2" ]]; then
  buildDeps=" \
    default-libmysqlclient-dev \
    libbz2-dev \
    libsasl2-dev \
    libuv1-dev \
    multiarch-support \
    " \
  runtimeDeps=" \
    imagemagick \
    libfreetype6-dev \
    libgmp-dev \
    libicu-dev \
    libjpeg-dev \
    libkrb5-dev \
    libldap2-dev \
    libmagickwand-dev \
    libmemcached-dev \
    libmemcachedutil2 \
    libpng-dev \
    libpq-dev \
    librabbitmq-dev \
    libssl-dev \
    libxml2-dev \
    libzip-dev \
    "
else
  buildDeps=" \
    default-libmysqlclient-dev \
    libbz2-dev \
    libsasl2-dev \
    libuv1-dev \
    multiarch-support \
    " \
  runtimeDeps=" \
    imagemagick \
    libfreetype6-dev \
    libgmp-dev \
    libicu-dev \
    libjpeg-dev \
    libkrb5-dev \
    libldap2-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libmemcachedutil2 \
    libpng-dev \
    libpq-dev \
    librabbitmq-dev \
    libxml2-dev \
    mcrypt \
    "
fi

DEBIAN_FRONTEND=noninteractive apt-get install -yqq $buildDeps \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yqq $runtimeDeps \
  && rm -rf /var/lib/apt/lists/* \
  && docker-php-ext-install -j$(nproc) $extensions \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j$(nproc) gd \
  && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
  && docker-php-ext-install -j$(nproc) ldap \
  && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
  && docker-php-ext-install -j$(nproc) imap \
  && docker-php-source delete

docker-php-source extract \
    && curl -L -o /tmp/cassandra-cpp-driver.deb "https://downloads.datastax.com/cpp-driver/ubuntu/18.04/cassandra/v2.14.0/cassandra-cpp-driver_2.14.0-1_amd64.deb" \
    && curl -L -o /tmp/cassandra-cpp-driver-dev.deb "https://downloads.datastax.com/cpp-driver/ubuntu/18.04/cassandra/v2.14.0/cassandra-cpp-driver-dev_2.14.0-1_amd64.deb" \
    && dpkg -i /tmp/cassandra-cpp-driver.deb /tmp/cassandra-cpp-driver-dev.deb \
    && rm /tmp/cassandra-cpp-driver*.deb \
    && curl -L -o /tmp/cassandra.tar.gz "https://github.com/datastax/php-driver/archive/v1.3.2.tar.gz" \
    && tar xfz /tmp/cassandra.tar.gz \
    && rm -r /tmp/cassandra.tar.gz \
    && mv php-driver-*/ext /usr/src/php/ext/cassandra \
    && rm -rf php-driver-* \
    && docker-php-ext-install cassandra \
    && docker-php-source delete

if [[ $PHP_VERSION == "7.2" ]]; then
  docker-php-source extract \
    && git clone https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached/ \
    && docker-php-ext-install memcached \
    && docker-php-ext-enable memcached \
    && docker-php-source delete \

  pecl channel-update pecl.php.net \
    && pecl install amqp redis apcu mongodb imagick xdebug \
    && docker-php-ext-enable amqp redis apcu mongodb imagick xdebug

elif [[ $PHP_VERSION == "7.3" ]]; then
  docker-php-source extract \
    && git clone https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached/ \
    && docker-php-ext-install memcached \
    && docker-php-ext-enable memcached \
    && docker-php-source delete \

  pecl channel-update pecl.php.net \
    && pecl install amqp redis apcu mongodb imagick xdebug-beta \
    && docker-php-ext-enable amqp redis apcu mongodb imagick xdebug

else
  apt-get update && docker-php-ext-install -j$(nproc) mcrypt
  pecl channel-update pecl.php.net \
    && pecl install amqp redis mongodb xdebug apcu memcached imagick \
    && docker-php-ext-enable amqp redis mongodb xdebug apcu memcached imagick
fi

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

echo "memory_limit=512M" > /usr/local/etc/php/conf.d/zz-conf.ini

apt-get purge -yqq --auto-remove $buildDeps
