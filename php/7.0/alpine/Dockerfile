FROM node:alpine

LABEL maintainer="Eduardo Bizarro <eduardo@zendev.com.br>" \
      php="7.0" \
      node="8"

# Set correct environment variables
ENV HOME="/root" \
    COMPOSER_HOME=$HOME/composer \
    COMPOSER_ALLOW_SUPERUSER=1 \
    PATH=$HOME/.yarn/bin:$PATH

WORKDIR /tmp

# COPY INSTALL SCRIPTS
COPY ./php/scripts/alpine/*.sh /tmp/
RUN chmod +x /tmp/*.sh

ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

# Install
RUN apk add --update --no-cache bash \
    && bash ./packages.sh \
    && echo "@php http://php.codecasts.rocks/v3.6/php-7.0" >> /etc/apk/repositories \
    && bash ./extensions.sh \
    && bash ./composer.sh \
    && bash ./yarn.sh \
    && bash ./cleanup.sh

RUN mkdir -p /var/www/html

WORKDIR /var/www/html
