#!/bin/bash

apt-get remove --purge -yqq $BUILD_PACKAGES apt-utils libc-client-dev make autoconf build-essential \
    && apt-get autoremove -y \
    && apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
