apk --update --no-cache add \
  zlib-dev \
  libxml2-dev \
  imap-dev \
  freetype-dev \
  libjpeg-turbo-dev \
  libltdl \
  libtool \
  libmcrypt-dev \
  libpng-dev \
  krb5-dev \
  icu-dev \
  readline-dev \
  bzip2-dev \
  curl-dev \
  libxslt-dev \
  imagemagick-dev \
  gmp-dev \
  postgresql-dev \
  sqlite3
  
docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) \
    bcmath \
    bz2 \
    exif \
    gd \
    gmp \
    iconv \
    imap \
    intl \
    json \
    mcrypt \
    opcache \
    pcntl \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pdo_sqlite \
    pgsql \
    readline \
    soap \
    xml \
    xmlrpc \
    xsl \
    zip

if [[ $PHP_VERSION =~ "7.1" ]]; then
  git clone --depth 1 "https://github.com/xdebug/xdebug" \
    && cd xdebug \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && docker-php-ext-enable xdebug
fi

if [[ $PHP_VERSION =~ "7.0" ]]; then
  pecl install xdebug \
    && docker-php-ext-enable xdebug
fi

docker-php-source extract \
    && apk add --no-cache --virtual .phpize-deps-configure $PHPIZE_DEPS \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && apk del .phpize-deps-configure \
    && docker-php-source delete

pecl install redis mongodb imagick \
  && docker-php-ext-enable redis mongodb imagick

echo "memory_limit=512M" > /usr/local/etc/php/conf.d/zz-conf.ini
