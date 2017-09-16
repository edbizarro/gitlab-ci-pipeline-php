#!/bin/bash

apk del --purge grep build-base \
  && rm -rf /var/cache/apk/* /tmp/* /usr/share/man
