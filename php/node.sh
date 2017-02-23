#!/bin/bash

# NODE JS
curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
    DEBIAN_FRONTEND=noninteractive apt-get install nodejs --no-install-recommends -yqq

curl -o- -L https://yarnpkg.com/install.sh | bash
