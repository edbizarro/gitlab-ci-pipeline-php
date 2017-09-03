#!/bin/bash

DEBIAN_FRONTEND=noninteractive apt-get update \
  &&  DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
      openssh-client \
      unzip \
      git \
      curl \
      libc-client-dev \
      libkrb5-dev \
      zlib1g-dev \
      apt-utils \
      rsync \
      --no-install-recommends
