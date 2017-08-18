FROM node:alpine

LABEL maintainer="Eduardo Bizarro <eduardo@zendev.com.br>" \
      php="7.0" \
      node="8"

# Set correct environment variables
ENV HOME="/root" \
    COMPOSER_HOME=$HOME/composer \
    COMPOSER_ALLOW_SUPERUSER=1

ENV PATH $HOME/.yarn/bin:$PATH

RUN apk add --update --no-cache \
    bash \
    curl \
    g++ \
    gcc \
    git \
    grep \
    make \
    openssh-client \
    libressl-dev \
    libwebp-dev \
    libxml2-dev \
    icu-libs \
    tar \
    wget \
    rsync \
    && wget -O /etc/apk/keys/php-alpine.rsa.pub \
    http://php.codecasts.rocks/php-alpine.rsa.pub && \
    echo "http://php.codecasts.rocks/7.0" >> /etc/apk/repositories && \
    apk add --update --no-cache \
      php7 \
      php7-bcmath \
      php7-bz2 \
      php7-calendar \
      php7-common \
      php7-ctype \
      php7-curl \
      php7-dba \
      php7-dev \
      php7-dom \
      php7-embed \
      php7-enchant \
      php7-exif \
      php7-fpm \
      php7-ftp \
      php7-gd \
      php7-gettext \
      php7-gmp \
      php7-iconv \
      php7-imagick \
      php7-imap \
      php7-intl \
      php7-json \
      php7-ldap \
      php7-litespeed \
      php7-mbstring \
      php7-mcrypt \
      php7-memcached \
      php7-mysqli \
      php7-mysqlnd \
      php7-odbc \
      php7-opcache \
      php7-openssl \
      php7-pcntl \
      php7-pdo \
      php7-pdo_dblib \
      php7-pdo_mysql \
      php7-pdo_pgsql \
      php7-pdo_sqlite \
      php7-pear \
      php7-pgsql \
      php7-phar \
      php7-phpdbg \
      php7-posix \
      php7-pspell \
      php7-session \
      php7-shmop \
      php7-snmp \
      php7-soap \
      php7-sockets \
      php7-sqlite3 \
      php7-sysvmsg \
      php7-sysvsem \
      php7-sysvshm \
      php7-tidy \
      php7-tokenizer \
      php7-wddx \
      php7-xml \
      php7-xmlreader \
      php7-xmlrpc \
      php7-xmlwriter \
      php7-xsl \
      php7-zip \
      php7-zlib \
    && pecl install redis mongodb xdebug-2.5.4 apcu \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer global require hirak/prestissimo --prefer-dist --no-interaction \
    && rm -rf /root/.composer/cache/* \
    && curl -o- -L https://yarnpkg.com/install.sh | bash \
    && apk del --purge wget gcc g++ make grep \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man

RUN mkdir -p /var/www/html
WORKDIR /var/www/html
