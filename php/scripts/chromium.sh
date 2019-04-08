#!/bin/bash

set -euf -o pipefail

# Installing Chromium for Dusk
apt-get install -yqq \
    libgconf-2-4 \
    libxi6 \
    libnss3 \
    xvfb \
    --no-install-recommends \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
    && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get-update -yqq \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*
