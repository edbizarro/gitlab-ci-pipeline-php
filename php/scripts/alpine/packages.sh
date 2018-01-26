#!/bin/bash

apk update && apk upgrade

apk add --update --no-cache \
    curl \
    git \
    grep \
    openssl-dev \
    openssh-client \
    rsync \
    sudo \
    file \
    ca-certificates \
    python

apk add --no-cache --virtual .build-deps build-base autoconf
