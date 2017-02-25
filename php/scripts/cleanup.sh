#!/bin/bash

apt-get remove --purge -yqq $BUILD_PACKAGES apt-utils libc-client-dev \
    && apt-get remove --purge -yqq \
    && apt-get --purge autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
