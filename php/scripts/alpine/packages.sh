#!/bin/bash

apk add --update --no-cache \
    curl \
    git \
    grep \
    build-base \
    openssh-client \
    libxml2-dev \
    libzip-dev \
    libzip \
    openssl-dev \
    rsync \
    sudo \
    autoconf \
    gcc \
    g++

apk add --no-cache --virtual .build-deps \
        libstdc++ \
        binutils-gold \
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
