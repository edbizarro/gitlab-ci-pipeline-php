#!/bin/bash

apk update && apk upgrade --no-cache

apk add --no-cache \
    ca-certificates \
    curl \
    file \
    g++ \
    gcc \
    git \
    grep \
    make \
    python \
    rsync \
    sudo \
    openssl \
    openssl-dev\
    openssh-client

apk add --no-cache --virtual .build-deps build-base autoconf

rm -rf /usr/share/man
