#!/usr/bin/env bash

set -euo pipefail

apk del --purge grep build-base file openssl-dev

rm -rf /tmp/* \
        /usr/includes/* \
        /usr/share/man/* \
        /var/cache/apk/* \
        /var/tmp/*
