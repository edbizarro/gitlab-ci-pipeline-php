#!/usr/bin/env bash

set -euo pipefail

# NODE JS
curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && DEBIAN_FRONTEND=noninteractive apt-get install nodejs -yq \
    && npm i -g --force npm \
    && curl -o- -L https://yarnpkg.com/install.sh | bash \
    && npm cache clean --force

xargs sudo chmod a+x $HOME/.yarn/bin/yarn
