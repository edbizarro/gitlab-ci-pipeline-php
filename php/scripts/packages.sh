#!/bin/bash

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
  && apt-get upgrade -y \
  &&  DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
      apt-transport-https \
      openssh-client \
      unzip \
      git \
      curl \
      libc-client-dev \
      zlib1g-dev \
      apt-utils \
      rsync \
      sudo \
      gnupg2 \
      python \
      python-dev \
      --no-install-recommends
