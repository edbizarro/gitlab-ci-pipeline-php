#!/bin/bash

ln -s /usr/lib/npm/bin/npm-cli.js /usr/bin/npm

npm i -g npm@${NPM_VERSION}
npm i -g gulp

curl -o- -L https://yarnpkg.com/install.sh | bash

rm -rf /usr/share/man /var/cache/apk/* \
  /root/.npm /root/.node-gyp /root/.gnupg /usr/lib/node_modules/npm/man \
  /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html /usr/lib/node_modules/npm/scripts
