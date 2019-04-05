#!/bin/bash

apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    apt-utils \
    autoconf \
    build-essential \
    dpkg-dev \
    file \
    libc-client-dev \
    libc-dev \
    libpcre3-dev \
    pkg-config \
    re2c

apt-get autoremove -y
apt-get autoclean -y
rm -rf /var/cache/apt/ /var/lib/apt/lists/* /var/log/* /tmp/* /var/tmp/* /usr/share/doc/* /usr/share/groff/* /usr/share/info/* /usr/share/linda/* /usr/share/lintian/overrides/* /usr/share/locale/* /usr/share/man/* /usr/share/locale/* /usr/share/gnome/help/*/* /usr/share/doc/kde/HTML/*/* /usr/share/omf/*/*-*.emf
