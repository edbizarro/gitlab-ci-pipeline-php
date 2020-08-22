#!/usr/bin/env bash

set -euo pipefail

apk --update --no-cache add \
    g++ \
    gcc \
    git \
    grep \
    jq \
    libc-dev \
    make \
    mariadb-client \
    openssh-client \
    openssl \
    patch \
    python3 \
    rsync \
    sudo \
    zip

# persistent / runtime deps
apk add --update --no-cache --virtual .persistent-deps \
		ca-certificates \
		tar \
		xz \
    curl

apk add --update --no-cache \
    autoconf \
    build-base \
    file \
    openssl-dev
