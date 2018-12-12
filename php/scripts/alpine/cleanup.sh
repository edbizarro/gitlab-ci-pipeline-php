#!/bin/bash

set -euf -o pipefail

apk del --purge grep build-base .build-deps postgresql-dev

rm -rf \
        /tmp/* \
        /usr/includes/* \
        /usr/share/man/* \
        /usr/src/* \
        /var/cache/apk/* \
        /var/tmp/*
