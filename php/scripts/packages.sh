#!/bin/bash

set -euf -o pipefail

############################################################
# Speedup DPKG and don't use cache for packages
############################################################
# Taken from here: https://gist.github.com/kwk/55bb5b6a4b7457bef38d
#
# this forces dpkg not to call sync() after package extraction and speeds up
# install
echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
#
# we don't need and apt cache in a container
echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

DEBIAN_FRONTEND=noninteractive
  dpkg-reconfigure -f noninteractive tzdata \
  && apt-get update \
  && apt-get upgrade -yqq \
  &&  DEBIAN_FRONTEND=noninteractive apt-get install -yqq — no-install-recommends \
      apt-transport-https \
      apt-utils \
      build-essential \
      curl \
      git \
      gnupg2 \
      libc-client-dev \
      openssh-client \
      python \
      python-dev \
      rsync \
      sudo \
      unzip \
      zlib1g-dev \
      && rm -rf /var/lib/apt/lists/*
