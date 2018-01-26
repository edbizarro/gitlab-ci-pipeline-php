#!/bin/bash

apk update && apk upgrade

apk add --update --no-cache \
    curl \
    git \
    grep \
    openssh-client \
    rsync \
    sudo \
    file \
    ca-certificates \
    python

apk add --no-cache --virtual .build-deps build-base autoconf

if [[ $PHP_VERSION =~ "7.2" ]]; then
  apk add --update --no-cache libressl-dev
else
  apk add --update --no-cache openssl-dev
fi
