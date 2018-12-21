FROM php:7.3-fpm

LABEL maintainer="Eduardo Bizarro <eduardo@zendev.com.br>" \
      php="7.3" \
      node="11"

# Set correct environment variables
ENV IMAGE_USER=php
ENV HOME=/home/$IMAGE_USER
ENV COMPOSER_HOME=$HOME/.composer
ENV PATH=$HOME/.yarn/bin:$PATH
ENV GOSS_VERSION="0.3.6"
ENV PHP_VERSION="7.3"

USER root

WORKDIR /tmp

# COPY INSTALL SCRIPTS
COPY --from=composer:1 /usr/bin/composer /usr/bin/composer
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
       chown -R $IMAGE_USER:$IMAGE_USER /var/www $HOME \
    && composer global require "hirak/prestissimo:^0.3"  \
    && rm -rf ~/.composer/cache/* \
    && chown -R $IMAGE_USER:$IMAGE_USER $COMPOSER_HOME \
    && curl -fsSL https://goss.rocks/install | GOSS_VER=v${GOSS_VERSION} sh

USER $IMAGE_USER

WORKDIR /var/www/html
