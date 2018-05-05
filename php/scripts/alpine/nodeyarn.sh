#!/bin/bash

set -euf -o pipefail

export VERSION=v10.0.0

 # NVM
apk add --no-cache -U curl bash ca-certificates openssl ncurses coreutils python make gcc g++ libgcc linux-headers grep util-linux binutils findutils

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

source ~/.nvm/nvm.sh

nvm install -s node
nvm use --delete-prefix $VERSION
nvm alias default node
npm i -g npm

curl -o- -L https://yarnpkg.com/install.sh | bash
