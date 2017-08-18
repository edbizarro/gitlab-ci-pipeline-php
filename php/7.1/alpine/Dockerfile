FROM node:alpine

LABEL maintainer="Eduardo Bizarro <eduardo@zendev.com.br>" \
      php="7.1" \
      node="8"

# Set correct environment variables
ENV HOME="/root" \
    COMPOSER_HOME=$HOME/composer \
    COMPOSER_ALLOW_SUPERUSER=1

ENV PATH $HOME/.yarn/bin:$PATH

RUN apk add --update --no-cache \
    bash \
    curl \
    git \
    grep \
    build-base \
    openssh-client \
    libxml2-dev \
    libzip-dev \
    libzip \
    openssl-dev \
    rsync \
    && apk search -qe 'php7-*' | xargs apk add --update --no-cache \
    && pecl install redis mongodb xdebug apcu \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer global require hirak/prestissimo --prefer-dist --no-interaction \
    && rm -rf /root/.composer/cache/* \
    && curl -o- -L https://yarnpkg.com/install.sh | bash \
    && apk del --purge grep build-base \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man

RUN mkdir -p /var/www/html

WORKDIR /var/www/html
