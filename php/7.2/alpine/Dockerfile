FROM php:7.2-alpine

LABEL maintainer="Eduardo Bizarro <eduardo@zendev.com.br>" \
      php="7.2" \
      node="10"

# Set correct environment variables
ENV IMAGE_USER=php
ENV HOME=/home/$IMAGE_USER
ENV COMPOSER_HOME=$HOME/.composer
ENV PATH=$HOME/.yarn/bin:$PATH
ENV PHP_VERSION="7.2"
ENV GOSS_VERSION="0.3.5"

WORKDIR /tmp

# COPY INSTALL SCRIPTS
COPY ./php/scripts/alpine/*.sh /tmp/
COPY --from=composer:1.6 /usr/bin/composer /usr/bin/composer

RUN chmod +x /tmp/*.sh \
    && adduser -D $IMAGE_USER \
    && mkdir -p /var/www/html \
    && apk add --update --no-cache bash \
    && bash ./packages.sh \
    && bash ./extensions.sh \
    && bash ./nodeyarn.sh \
    && bash ./cleanup.sh \
    && composer global require "hirak/prestissimo:^0.3" \
    && chown -R $IMAGE_USER:$IMAGE_USER /var/www $HOME \
    && echo "$IMAGE_USER  ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers \
    && curl -fsSL https://goss.rocks/install | GOSS_VER=v${GOSS_VERSION} sh

USER $IMAGE_USER

WORKDIR /var/www/html

CMD ["php", "-a"]
