FROM php:5.6

LABEL maintainer "Eduardo Bizarro <eduardo@zendev.com.br>" \
      php="5.6" \
      node="7"

# Set correct environment variables
ENV HOME="/root" \
    PATH="~/.yarn/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

WORKDIR /tmp

# System packages

COPY ./php/packages.sh packages.sh
RUN chmod +x packages.sh \
    && bash ./packages.sh

# PHP Extensions

COPY ./php/extensions.sh extensions.sh
RUN chmod +x extensions.sh \
    && bash ./extensions.sh

# Composer

VOLUME /root/composer
# Environmental Variables
ENV COMPOSER_HOME /root/composer
COPY ./php/composer.sh composer.sh
RUN chmod +x composer.sh \
    && bash ./composer.sh

# Node & Yarn

COPY ./php/node.sh node.sh
RUN chmod +x node.sh \
    && bash ./node.sh


# Clean up

COPY ./php/cleanup.sh cleanup.sh
RUN chmod +x cleanup.sh \
    && bash ./cleanup.sh

WORKDIR /root
