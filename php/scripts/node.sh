#!/bin/bash

set -euf -o pipefail

# NODE JS
curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && DEBIAN_FRONTEND=noninteractive apt-get install nodejs --no-install-recommends -yqq \
    && npm install -g npm \
    && npm install -g gulp \
    && curl -o- -L https://yarnpkg.com/install.sh | bash
