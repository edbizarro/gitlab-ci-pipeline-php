FROM php:7.2-fpm

LABEL maintainer="Eduardo Bizarro <eduardo@zendev.com.br>" \
      php="7.2" \
      node="9"

# Set correct environment variables
ENV IMAGE_USER=php
ENV HOME=/home/$IMAGE_USER
ENV COMPOSER_HOME=$HOME/.composer
ENV PATH=$HOME/.yarn/bin:$PATH
ENV GOSS_VERSION="0.3.5"
ENV PHP_VERSION="7.2"

USER root

WORKDIR /tmp

# COPY INSTALL SCRIPTS
COPY ./php/scripts/*.sh /tmp/
RUN chmod +x /tmp/*.sh

# Install
RUN bash ./packages.sh \
    && bash ./extensions.sh \
    && bash ./node.sh \
    && bash ./cleanup.sh \
    && adduser --disabled-password --gecos "" $IMAGE_USER && \
       echo "$IMAGE_USER  ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers && \
       mkdir -p /var/www/html && \
       chown -R $IMAGE_USER:$IMAGE_USER /var/www $HOME /tmp

COPY --from=composer:1.6 /usr/bin/composer /usr/bin/composer

# Goss
RUN curl -fsSL https://goss.rocks/install | GOSS_VER=v${GOSS_VERSION} sh

USER $IMAGE_USER

WORKDIR /var/www/html
