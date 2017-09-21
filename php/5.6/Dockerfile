FROM php:5.6

LABEL maintainer "Eduardo Bizarro <eduardo@zendev.com.br>" \
      php="5.6" \
      node="8"

# Set correct environment variables
ENV IMAGE_USER=php
ENV HOME=/home/$IMAGE_USER
ENV COMPOSER_HOME=$HOME/.composer
ENV PATH=$HOME/.yarn/bin:$PATH

WORKDIR /tmp

# COPY INSTALL SCRIPTS
COPY ./php/scripts/*.sh /tmp/
RUN chmod +x /tmp/*.sh

RUN useradd -m -u 1000 $IMAGE_USER && \
    mkdir -p /var/www/html && \
    chown -R $IMAGE_USER:$IMAGE_USER /var/www

# Install
RUN bash ./packages.sh \
    && bash ./extensions.sh \
      # MONGO, xdebug and other extensions
      && pecl install mongodb xdebug-2.5.0 apcu-4.0.11 \
      && docker-php-ext-enable mongodb xdebug apcu \
    && bash ./composer.sh \
    && bash ./node.sh \
    && bash ./cleanup.sh

RUN chown -R $IMAGE_USER:$IMAGE_USER $HOME

USER $IMAGE_USER

WORKDIR /var/www/html
