#!/bin/bash

apk add --update --no-cache \
    curl \
    git \
    grep \
    openssl-dev \
    openssh-client \
    rsync \
    sudo \
    file \
    ca-certificates

apk add --no-cache --virtual .build-deps \
        libstdc++ \
        binutils-gold \
        build-base \
        autoconf \
        curl \
        g++ \
        gcc \
        gnupg \
        libgcc \
        linux-headers \
        make \
        python \
        pcre \
        pcre-dev \
        pcre-tools \
        perl \
        patch \
        patchutils \
        diffutils
