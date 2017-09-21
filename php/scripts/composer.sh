#!/bin/bash

# Install Composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install hirak/prestissimo to speedup composer installs.
composer global require hirak/prestissimo --prefer-dist --no-interaction \
    && rm -rf $HOME/.composer/cache/*
