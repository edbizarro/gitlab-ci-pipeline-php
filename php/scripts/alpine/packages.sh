#!/usr/bin/env bash

set -euf -o pipefail

apk update \
&& apk --no-cache upgrade \
&& apk --no-cache add \
    g++ \
    gcc \
    git \
    grep \
    libc-dev \
    make \
    mysql-client \
    openssh-client \
    openssl \
    python \
    rsync \
    sudo \
    zip

# persistent / runtime deps
apk add --no-cache --virtual .persistent-deps \
		ca-certificates \
		tar \
		xz \
    curl
apk add --no-cache \
    autoconf \
    build-base \
    file \
    openssl-dev
