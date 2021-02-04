#!/usr/bin/env bash

set -euo pipefail

############################################################
# Speedup DPKG and don't use cache for packages
############################################################
# Taken from here: https://gist.github.com/kwk/55bb5b6a4b7457bef38d
#
# this forces dpkg not to call sync() after package extraction and speeds up
# install
echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
# we don't need and apt cache in a container
echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache
echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf
export DEBIAN_FRONTEND=noninteractive
# Debian doesn't include MySQL, so install its repo manually, see guide:
# https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#repo-qg-apt-repo-manual-setup
# Install MySQL's PGP key, allow for retry as MIT keyserver is often very slow
apt-key adv --keyserver pgp.mit.edu --recv-keys 5072E1F5 || apt-key adv --keyserver pgp.mit.edu --recv-keys 5072E1F5
echo deb http://repo.mysql.com/apt/debian/ `lsb_release -sc` mysql-8.0 > /etc/apt/sources.list.d/mysql.list
dpkg-reconfigure -f noninteractive tzdata \
  && apt-get update \
  && apt-get install -yq \
      apt-transport-https \
      apt-utils \
      ca-certificates \
  && apt-get install -yq \
      build-essential \
      curl \
      git \
      gnupg2 \
      jq \
      libc-client-dev \
      mysql-client \
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
