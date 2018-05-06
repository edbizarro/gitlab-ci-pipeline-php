#!/bin/bash

apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    build-essential \
    apt-utils \
    libc-client-dev\
    autoconf \
    dpkg-dev \
    file \
    g++ \
    gcc \
    libc-dev \
    libpcre3-dev \
    make \
    pkg-config \
    re2c

apt-get autoremove -y
apt-get autoclean -y
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
