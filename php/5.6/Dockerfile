FROM ubuntu:16.04

LABEL maintainer "Eduardo Bizarro <eduardo@zendev.com.br>" \			
			architecture "amd64" \
			php "5.6" \
      node "7"

# Set correct environment variables
ENV HOME /root

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
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
    libssl-dev \
    libcurl4-openssl-dev \
    libsasl2-dev \
    --no-install-recommends && rm -r /var/lib/apt/lists/* \
    && apt-get --purge autoremove -y

#NODE JS
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
    apt-get install nodejs -qq && \
    npm install -g npm gulp 

# YARN
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

# PHP Extensions
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ondrej/php && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y --no-install-recommends php-pear php5.6-dev php5.6-fpm php5.6-mcrypt php5.6-zip php5.6-xml php5.6-mbstring php5.6-curl php5.6-json php5.6-mysql php5.6-tokenizer php5.6-cli && \   
    wget https://xdebug.org/files/xdebug-2.4.0rc4.tgz && \
    tar -xzf xdebug-2.4.0rc4.tgz && \
    rm xdebug-2.4.0rc4.tgz && \
    cd xdebug-2.4.0RC4 && \
    phpize && \
    ./configure --enable-xdebug && \
    make && \
    cp modules/xdebug.so /usr/lib/. && \
    echo 'zend_extension="/usr/lib/xdebug.so"' > /etc/php/5.6/cli/conf.d/20-xdebug.ini && \
    echo 'xdebug.remote_enable=1' >> /etc/php/5.6/cli/conf.d/20-xdebug.ini

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
		libssl-dev \
    libcurl4-openssl-dev \
    libsasl2-dev \
    && apt-get autoclean -y \
    && apt-get --purge autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*