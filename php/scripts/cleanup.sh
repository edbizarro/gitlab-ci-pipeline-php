#!/bin/bash

export RUNTIME_PACKAGES="ca-certificates libmysqlclient-dev openssh-client unzip git curl nodejs libmcrypt-dev libfreetype6-dev libjpeg62-turbo-dev libpng12-dev libssl-dev libicu-dev libbz2-dev libc-client-dev libkrb5-dev zlib1g-dev"

apt-get remove --purge -yqq $BUILD_PACKAGES $(apt-mark showauto) apt-utils \
    && apt-get install -yqq apt-transport-https lsb-release \
    && apt-get install -yqq apt-transport-https lsb-release $RUNTIME_PACKAGES \
    && apt-get --purge autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
