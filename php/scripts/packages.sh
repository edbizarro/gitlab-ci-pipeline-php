#!/bin/bash

export RUNTIME_PACKAGES="ca-certificates libmysqlclient-dev openssh-client unzip git curl nodejs libmcrypt-dev libfreetype6-dev libjpeg62-turbo-dev libpng12-dev libssl-dev libicu-dev libbz2-dev libc-client-dev libkrb5-dev zlib1g-dev"

apt-get update \
&& DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
      $RUNTIME_PACKAGES \
      apt-utils \
      --no-install-recommends
