#!/bin/bash

set -euo pipefail

# Installing Chromium for Dusk
apt-get update \
  && apt-get install -yq \
    libgconf-2-4 \
    libnss3 \
    libxi6 \
    libgbm-dev \
    wget \
    xvfb

    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
    && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update -yqq \
    && apt-get install -yqq google-chrome-stable
