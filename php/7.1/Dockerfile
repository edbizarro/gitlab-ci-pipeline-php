FROM ubuntu:16.04

LABEL maintainer "Eduardo Bizarro <eduardo@zendev.com.br>" \			
			architecture "amd64" \
			php "7.1" \
      node "7"

# Set correct environment variables
ENV HOME="/root" \
    PATH="~/.yarn/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \    
    DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    software-properties-common \
    python-software-properties \
    build-essential \
    curl \
    git \
    unzip \
    mcrypt \
    wget \
    openssl \
    autoconf \
    g++ \
    make \
    --no-install-recommends

# OpenSSL
RUN mkdir -p /usr/local/openssl/include/openssl/ && \
    ln -s /usr/include/openssl/evp.h /usr/local/openssl/include/openssl/evp.h && \
    mkdir -p /usr/local/openssl/lib/ && \
    ln -s /usr/lib/x86_64-linux-gnu/libssl.a /usr/local/openssl/lib/libssl.a && \
    ln -s /usr/lib/x86_64-linux-gnu/libssl.so /usr/local/openssl/lib/

# NODE JS
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
    apt-get install nodejs --no-install-recommends -yqq && \
    npm install -g gulp

# YARN
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

# PHP Extensions
RUN add-apt-repository -y ppa:ondrej/php && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yqq --no-install-recommends \
    php-pear \
    php7.1-dev \
		php7.1-fpm \
    php7.1-mcrypt \
    php7.1-xml \
    php7.1-mbstring \
    php7.1-curl \
    php7.1-json \
    php7.1-mysql \
    php7.1-tokenizer \
    php7.1-cli \
    php7.1-imap \
    php7.1-gd && \
    apt-get remove -y --purge php5 php5-common && \
    rm -r /var/lib/apt/lists/*

# MONGO extension
RUN pecl install mongodb && \
    echo "extension=mongodb.so" > /etc/php/7.1/cli/conf.d/20-mongodb.ini && \
    echo "extension=mongodb.so" > /etc/php/7.1/mods-available/mongodb.ini

# Run xdebug installation.
RUN wget --no-check-certificate https://xdebug.org/files/xdebug-2.5.0.tgz && \
    tar -xzf xdebug-2.5.0.tgz && \
    rm xdebug-2.5.0.tgz && \
    cd xdebug-2.5.0 && \
    phpize && \
    ./configure --enable-xdebug && \
    make && \
    cp modules/xdebug.so /usr/lib/. && \
    echo 'zend_extension="/usr/lib/xdebug.so"' > /etc/php/7.1/cli/conf.d/20-xdebug.ini && \
    echo 'xdebug.remote_enable=1' >> /etc/php/7.1/cli/conf.d/20-xdebug.ini

# Time Zone
RUN echo "date.timezone=America/Sao_Paulo" > /etc/php/7.1/cli/conf.d/date_timezone.ini

VOLUME /root/composer

# Environmental Variables
ENV COMPOSER_HOME /root/composer

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Run phpunit installation.
RUN composer global require hirak/prestissimo --prefer-dist --no-interaction && \
    rm -rf /root/.composer/cache/*

RUN DEBIAN_FRONTEND=noninteractive apt-get remove --purge -y \
    autoconf \
    g++ \
    make \
    software-properties-common \
    python-software-properties \
    build-essential \
    && apt-get autoclean -y \
    && apt-get --purge autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
