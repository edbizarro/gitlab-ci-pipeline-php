#!/usr/bin/env bash

set -euf -o pipefail

apk update && apk upgrade --no-cache

apk add --no-cache \
    g++ \
    gcc \
    git \
    grep \
    libc-dev \
    make \
    openssh-client \
    openssl \
    python \
    rsync \
    sudo

# persistent / runtime deps
apk add --no-cache --virtual .persistent-deps \
		ca-certificates \
		tar \
		xz \
    curl

apk add --no-cache --virtual .build-deps \
    autoconf \
    build-base \
    file \
    openssl-dev
