#!/bin/bash

set -euf -o pipefail

apk del --purge grep build-base .build-deps

rm -rf \
        /tmp/* \
        /usr/includes/* \
        /usr/share/man/* \
        /usr/src/* \
        /var/cache/apk/* \
        /var/tmp/*

apk del --purge bzip2-dev \
                curl-dev \
                cyrus-sasl-dev \
                freetype-dev \
                gmp-dev \
                icu-dev \
                imagemagick \
                imap-dev \
                krb5-dev \
                libedit-dev \
                libjpeg-turbo-dev \
                libmemcached-dev \
                libpng-dev \
                libxml2-dev \
                libxslt-dev \
                openldap-dev \
                pcre-dev \
                postgresql-dev \
                readline-dev \
                sqlite-dev \
                zlib-dev
