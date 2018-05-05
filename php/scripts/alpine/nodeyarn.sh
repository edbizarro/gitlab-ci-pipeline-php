#!/bin/bash

set -euf -o pipefail

export NODE_VERSION=v10.0.0

 # NVM
apk add --no-cache -U  openssl ncurses coreutils make gcc g++ libgcc linux-headers grep util-linux binutils findutils

cd /tmp \
  && curl https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.gz > nodejs-src.tar.gz \
  && tar xf nodejs-src.tar.gz \
  && cd node-v${NODE_VERSION} \
  && ./configure --prefix=/usr \
  && make -j`getconf _NPROCESSORS_ONLN` \
  && make install
npm i -g npm

curl -o- -L https://yarnpkg.com/install.sh | bash
