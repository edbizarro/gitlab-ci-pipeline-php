#!/bin/bash

apk del --purge \
    autoconf \
    gcc \
    g++ \
    make \
    file \
    libc-dev \
    libltdl \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man
