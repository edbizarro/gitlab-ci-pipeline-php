#!/bin/bash

set -euf -o pipefail

# NODE JS
curl -sL https://deb.nodesource.com/setup_11.x | bash - \
    && DEBIAN_FRONTEND=noninteractive apt-get install nodejs --no-install-recommends -yqq \
    && npm i -g npm \
    && npm i -g gulp \
    && curl -o- -L https://yarnpkg.com/install.sh | bash

xargs sudo chmod a+x $HOME/.yarn/bin/yarn
