#!/bin/bash

apk update && apk upgrade

apk add --no-cache \
    ca-certificates \
    curl \
    file \
    g++ \
    gcc \
    git \
    grep \
    make \
    openssh-client \
    python \
    rsync \
    sudo

if [[ $PHP_VERSION = "7.2" ]]; then
  apk add --no-cache libressl-dev
else
  apk add --no-cache openssl-dev
fi

apk add --no-cache --virtual .build-deps build-base autoconf

rm -rf /usr/share/man
