#!/bin/bash

apt-get update \
&& apt-get upgrade -y \
&& apt-get install -yqq \
      $BUILD_PACKAGES \
      git \
      curl \
      unzip \
      openssh-client \
      mysql-client \
      --no-install-recommends
