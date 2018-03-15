FROM php:7.1-alpine

LABEL maintainer="Eduardo Bizarro <eduardo@zendev.com.br>" \
      php="7.1" \
      node="9"

# Set correct environment variables
ENV IMAGE_USER=php
ENV HOME=/home/$IMAGE_USER
ENV COMPOSER_HOME=$HOME/.composer
ENV PHP_VERSION="7.1"
ENV GOSS_VERSION="0.3.5"

WORKDIR /tmp

# COPY INSTALL SCRIPTS
COPY ./php/scripts/alpine/*.sh /tmp/
RUN chmod +x /tmp/*.sh

RUN adduser -D $IMAGE_USER && \
    mkdir -p /var/www/html

# Install
RUN apk add --update --no-cache bash \
    && bash ./packages.sh \
    && bash ./extensions.sh \
    && bash ./nodeyarn.sh \
    && bash ./cleanup.sh

COPY --from=composer:1.6 /usr/bin/composer /usr/bin/composer

RUN composer global require "hirak/prestissimo:^0.3"

RUN chown -R $IMAGE_USER:$IMAGE_USER $HOME /var/www /tmp
RUN echo "$IMAGE_USER  ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers

# Goss
RUN curl -fsSL https://goss.rocks/install | GOSS_VER=v${GOSS_VERSION} sh

USER $IMAGE_USER

WORKDIR /var/www/html

CMD ["php", "-a"]
