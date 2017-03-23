FROM php:7.1

LABEL maintainer="Eduardo Bizarro <eduardo@zendev.com.br>" \
      php="7.1" \
      node="7"

# Set correct environment variables
ENV HOME="/root" \
    COMPOSER_HOME=$HOME/composer

ENV PATH $HOME/.yarn/bin:$PATH

WORKDIR /tmp

# COPY INSTALL SCRIPTS
COPY ./php/scripts/*.sh /tmp/
RUN chmod +x /tmp/*.sh

# Install
RUN bash ./packages.sh \
    && bash ./extensions.sh \
    && bash ./composer.sh \
    && bash ./node.sh \
    && bash ./cleanup.sh

WORKDIR /root
