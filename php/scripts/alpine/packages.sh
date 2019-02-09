#!/bin/bash

set -euf -o pipefail

apk update && apk upgrade --no-cache

apk add --no-cache \
    git \
    grep \
    openssh-client \
    openssl \
    python \
    rsync \
    sudo

# persistent / runtime deps
RUN apk add --no-cache --virtual .persistent-deps \
		ca-certificates \
		tar \
		xz

apk add --no-cache --virtual .build-deps \
    autoconf \
    build-base \
    curl \
    file \
    g++ \
    gcc \
    libc-dev \
    make \
    openssl-dev
