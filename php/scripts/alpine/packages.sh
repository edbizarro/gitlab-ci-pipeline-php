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

if [[ $PHP_VERSION =~ "7.2" ]]
then
  echo $PHP_VERSION
  apk add --update --no-cache libressl-dev
else
  echo $PHP_VERSION
  apk add --update --no-cache openssl-dev
fi

apk add --no-cache --virtual .build-deps build-base autoconf
