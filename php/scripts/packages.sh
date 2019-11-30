#!/usr/bin/env bash

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
echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf

DEBIAN_FRONTEND=noninteractive
  dpkg-reconfigure -f noninteractive tzdata \
  && apt-get update \
  && apt-get upgrade -yqq \
  &&  DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
      apt-transport-https \
      apt-utils \
      ca-certificates \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
      build-essential \
      curl \
      git \
      gnupg2 \
      jq \
      libc-client-dev \
      mariadb-client \
      mongo-tools \
      openssh-client \
      python \
      python-dev \
      rsync \
      sudo \
      unzip \
      zip \
      zlib1g-dev \
      && rm -rf /var/lib/apt/lists/*
