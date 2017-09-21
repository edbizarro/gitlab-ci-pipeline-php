FROM node:alpine

LABEL maintainer="Eduardo Bizarro <eduardo@zendev.com.br>" \
      php="7.1" \
      node="8"

# Set correct environment variables
ENV IMAGE_USER=php
ENV HOME=/home/$IMAGE_USER
ENV COMPOSER_HOME=$HOME/.composer
ENV PATH=$HOME/.yarn/bin:$PATH

ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

WORKDIR /tmp

# COPY INSTALL SCRIPTS
COPY ./php/scripts/alpine/*.sh /tmp/
RUN chmod +x /tmp/*.sh

RUN adduser -D $IMAGE_USER && \
    mkdir -p /var/www/html

# Install
RUN apk add --update --no-cache bash \
    && bash ./packages.sh \
    && echo "@php http://php.codecasts.rocks/v3.6/php-7.1" >> /etc/apk/repositories \
    && bash ./extensions.sh \
    && bash ./composer.sh \
    && bash ./yarn.sh \
    && bash ./cleanup.sh

RUN chown -R $IMAGE_USER:$IMAGE_USER $HOME /var/www
RUN echo "$IMAGE_USER  ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers

USER $IMAGE_USER

WORKDIR /var/www/html
