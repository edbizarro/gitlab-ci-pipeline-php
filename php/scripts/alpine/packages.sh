#!/bin/bash

set -euf -o pipefail

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
    python \
    gcc \
    g++ \
    make

if [[ $PHP_VERSION =~ "7.2" ]]; then
  apk add --update --no-cache libressl-dev
else
  apk add --update --no-cache openssl-dev
fi

apk add --no-cache --virtual .build-deps build-base autoconf

rm -rf /usr/share/man /var/cache/apk/*
