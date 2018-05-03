#!/bin/bash

set -euf -o pipefail

apk del --purge grep build-base .build-deps

rm -rf /var/cache/apk/* /tmp/* /usr/share/man /usr/include/php7 /usr/lib/php7/build /usr/lib/php7/modules/*.a
