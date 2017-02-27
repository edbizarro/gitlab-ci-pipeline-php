FROM php:5.6-alpine

LABEL maintainer="Eduardo Bizarro <eduardo@zendev.com.br>" \
      php="5.6" \
      node="7"

# Set correct environment variables
ENV HOME="/root" \
    PATH="~/.yarn/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
    COMPOSER_HOME="/root/composer"

WORKDIR /tmp

# COPY INSTALL SCRIPTS
COPY ./php/scripts/alpine/*.sh /tmp/
RUN chmod +x /tmp/*.sh

RUN apk add --update --no-cache bash

# Install
RUN bash ./packages.sh \
    && bash ./composer.sh \
    && bash ./node.sh \
    && bash ./cleanup.sh

WORKDIR /root
