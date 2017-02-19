FROM ubuntu:16.04

LABEL maintainer "Eduardo Bizarro <eduardo@zendev.com.br>" \			
			architecture "amd64" \
			php "7.0" \
      node "7"

# Set correct environment variables
ENV HOME="/root" \
    PATH="~/.yarn/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \    
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
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
    --no-install-recommends && rm -r /var/lib/apt/lists/* \
    && apt-get --purge autoremove -y

# OpenSSL
RUN mkdir -p /usr/local/openssl/include/openssl/ && \
    ln -s /usr/include/openssl/evp.h /usr/local/openssl/include/openssl/evp.h && \
    mkdir -p /usr/local/openssl/lib/ && \
    ln -s /usr/lib/x86_64-linux-gnu/libssl.a /usr/local/openssl/lib/libssl.a && \
    ln -s /usr/lib/x86_64-linux-gnu/libssl.so /usr/local/openssl/lib/

# NODE JS
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
    apt-get install nodejs -qq && \
    npm install -g gulp

# YARN
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

# PHP Extensions

RUN add-apt-repository -y ppa:ondrej/php && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
    php-pear \
		php-xml \
		php-curl \
    php7.0-dev \
		php7.1-fpm \
    php7.0-mcrypt \
    php7.0-xml \
    php7.0-mbstring \
    php7.0-curl \
    php7.0-json \
    php7.0-mysql \
    php7.0-tokenizer \
    php7.0-cli \
    php7.0-imap \
    php7.0-gd \
    --no-install-recommends && rm -r /var/lib/apt/lists/* && \        
    apt-get --purge autoremove -y
    

# MONGO extension
RUN pecl install mongodb && \
    echo "extension=mongodb.so" > /etc/php/7.0/cli/conf.d/20-mongodb.ini && \
    echo "extension=mongodb.so" > /etc/php/7.0/mods-available/mongodb.ini

RUN wget --no-check-certificate https://xdebug.org/files/xdebug-2.5.0.tgz && \
    tar -xzf xdebug-2.5.0.tgz && \
    rm xdebug-2.5.0.tgz && \
    cd xdebug-2.5.0 && \
    phpize && \
    ./configure --enable-xdebug && \
    make && \
    cp modules/xdebug.so /usr/lib/. && \
    echo 'zend_extension="/usr/lib/xdebug.so"' > /etc/php/7.0/cli/conf.d/20-xdebug.ini && \
    echo 'xdebug.remote_enable=1' >> /etc/php/7.0/cli/conf.d/20-xdebug.ini

# Time Zone
RUN echo "date.timezone=America/Sao_Paulo" > /etc/php/7.0/cli/conf.d/date_timezone.ini

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
