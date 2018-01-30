#!/bin/bash
if [[ $PHP_VERSION =~ "7.2" ]]; then
  buildDeps=" \
          default-libmysqlclient-dev \
          libbz2-dev \
          libsasl2-dev \
      " \
      runtimeDeps=" \
          libfreetype6-dev \
          libicu-dev \
          libjpeg-dev \
          libldap2-dev \
          libmemcachedutil2 \
          libmemcached-dev \
          libpng-dev \
          libpq-dev \
          libxml2-dev \
          libmagickwand-dev \
          imagemagick \
          libssl-dev \
          libkrb5-dev \
      "
else

  buildDeps=" \
        libbz2-dev \
        libmysqlclient-dev \
        libsasl2-dev \
    " \
    runtimeDeps=" \
        libfreetype6-dev \
        libicu-dev \
        libjpeg-dev \
        libldap2-dev \
        libmcrypt-dev \
        libmemcached-dev \
        libmemcachedutil2 \
        libpng12-dev \
        libpq-dev \
        libxml2-dev \
        libkrb5-dev \
        libmagickwand-dev \
        imagemagick \
    "
fi

    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y $buildDeps $runtimeDeps --no-install-recommends \
    && docker-php-ext-install -j$(nproc) exif xml xmlrpc pcntl bcmath bz2 calendar iconv intl mbstring mysqli opcache pdo_mysql pdo_pgsql pgsql soap zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install -j$(nproc) ldap \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install -j$(nproc) imap \
    && docker-php-source delete \
    && rm -r /var/lib/apt/lists/*

if [[ $PHP_VERSION =~ "7.2" ]]; then
  docker-php-source extract \
    && git clone --branch REL3_0 https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached/ \
    && docker-php-ext-install memcached \
    && docker-php-ext-enable memcached \
    && docker-php-source delete \

  pecl channel-update pecl.php.net \
    && pecl install redis apcu mongodb imagick \
    && docker-php-ext-enable redis apcu mongodb imagick
else
  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y mcrypt
  docker-php-ext-install -j$(nproc) mcrypt
  pecl channel-update pecl.php.net \
    && pecl install redis mongodb xdebug apcu memcached imagick \
    && docker-php-ext-enable redis mongodb xdebug apcu memcached imagick
fi

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

