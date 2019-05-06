#!/usr/bin/env bash

ln -s /usr/lib/npm/bin/npm-cli.js /usr/bin/npm

npm i -g npm@${NPM_VERSION}

curl -o- -L https://yarnpkg.com/install.sh | bash

mkdir $HOME/.config

rm -rf /usr/share/man /var/cache/apk/* \
  /root/.npm /root/.node-gyp /root/.gnupg /usr/lib/node_modules/npm/man \
  /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html /usr/lib/node_modules/npm/scripts
