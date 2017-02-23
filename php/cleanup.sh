#!/bin/bash

AUTO_ADDED_PACKAGES=`apt-mark showauto`

apt-get remove --purge -yqq $BUILD_PACKAGES

apt-get autoclean -y \
    && apt-get --purge autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
