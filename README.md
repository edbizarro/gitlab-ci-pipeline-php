# Build and test PHP applications with Gitlab CI (or any other CI platform)

> Docker images with everything you'll need to build and test PHP applications.

![Logo](https://raw.githubusercontent.com/edbizarro/gitlab-ci-pipeline-php/master/gitlab-ci-pipeline-php.png)

---
![GitHub last commit](https://img.shields.io/github/last-commit/edbizarro/gitlab-ci-pipeline-php.svg?style=for-the-badge&logo=git) [![Docker Pulls](https://img.shields.io/docker/pulls/edbizarro/gitlab-ci-pipeline-php.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/edbizarro/gitlab-ci-pipeline-php/) [![building status](https://gitlab.com/edbizarro/gitlab-ci-pipeline-php/badges/master/pipeline.svg)](https://gitlab.com/edbizarro/gitlab-ci-pipeline-php/commits/master)

---

## Based on [Official PHP images](https://hub.docker.com/_/php/)

> PHP 7.4 available

- ```7.4```, ```7```, ```latest``` [(7.4/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.4/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.4.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.4 "Get your own image badge on microbadger.com")

- ```7.4-alpine```, ```alpine``` [(7.4/alpine/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.4/alpine/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.4-alpine.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.4-alpine "Get your own image badge on microbadger.com")


- ```7.4-fpm```, ```fpm``` [(7.4/fpm/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.4/fpm/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.4-fpm.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.4-fpm "Get your own image badge on microbadger.com")

- ```7.3``` [(7.3/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.3/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.3.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.3 "Get your own image badge on microbadger.com")

- ```7.3-alpine``` [(7.3/alpine/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.3/alpine/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.3-alpine.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.3-alpine "Get your own image badge on microbadger.com")

- ```7.3-alpine-lts```, ```alpine-lts``` [(7.3/alpine/Dockerfile-lts)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.3/alpine/Dockerfile-lts) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.3-alpine-lts.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.3-alpine-lts "Get your own image badge on microbadger.com")

- ```7.3-fpm``` [(7.3/fpm/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.3/fpm/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.3-fpm.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.3-fpm "Get your own image badge on microbadger.com")

- ```7.2``` [(7.2/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.2/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.2.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.2 "Get your own image badge on microbadger.com")

- ```7.2-alpine``` [(7.2/alpine/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.2/alpine/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.2-alpine.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.2-alpine "Get your own image badge on microbadger.com")

- ```7.2-alpine-lts``` [(7.2/alpine/Dockerfile-lts)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.2/alpine/Dockerfile-lts) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.2-alpine-lts.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.2-alpine-lts "Get your own image badge on microbadger.com")

- ```7.2-fpm``` [(7.2/fpm/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.2/fpm/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.2-fpm.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.2-fpm "Get your own image badge on microbadger.com")

All versions come with [Node 12](https://nodejs.org/en/), [Composer](https://getcomposer.org/) and [Yarn](https://yarnpkg.com)

> PHP 7.0.x and 7.1.x are now deprecated and removed from this repo since they reach end of life. Your scripts will not stop working since the images are still available but they will not be receiving new builds from now on. For more information please visit https://www.php.net/supported-versions.php

---

## Laravel projects

All images come with PHP (with all laravel required extensions), Composer (with [hirak/prestissimo](https://github.com/hirak/prestissimo) to speed up installs), Node and [Yarn](https://yarnpkg.com).

Everything you need to test Laravel projects :D

### Laravel Dusk

To run Dusk tests we need chromium installed on the image, because of that we have a special tag for this case.

- ```7.3-chromium``` [(7.3/chromium/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.3/chromium/Dockerfile) [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.3-chromium.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.3-chromium "Get your own image badge on microbadger.com")
- ```7.2-chromium``` [(7.2/chromium/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.2/chromium/Dockerfile) [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.2-chromium.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.2-chromium "Get your own image badge on microbadger.com")
- ```7.1-chromium``` [(7.1/chromium/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.1/chromium/Dockerfile) [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.1-chromium.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.1-chromium "Get your own image badge on microbadger.com")

Check *Dusk example* for more details.

---

## Gitlab pipeline examples

### Laravel test examples

#### Simple ```.gitlab-ci.yml``` using mysql service

```yaml
# Variables
variables:
  MYSQL_ROOT_PASSWORD: root
  MYSQL_USER: homestead
  MYSQL_PASSWORD: secret
  MYSQL_DATABASE: homestead
  DB_HOST: mysql

test:
  stage: test
  services:
    - mysql:5.7
  image: edbizarro/gitlab-ci-pipeline-php:7.3-alpine
  script:
    - yarn install --pure-lockfile
    - composer install --prefer-dist --no-ansi --no-interaction --no-progress
    - cp .env.example .env
    - php artisan key:generate
    - php artisan migrate:refresh --seed
    - ./vendor/phpunit/phpunit/phpunit -v --coverage-text --colors=never --stderr
```

#### Advanced ```.gitlab-ci.yml``` using mysql service, stages and cache

```yaml
stages:
  - test
  - deploy

# Variables
variables:
  MYSQL_ROOT_PASSWORD: root
  MYSQL_USER: homestead
  MYSQL_PASSWORD: secret
  MYSQL_DATABASE: homestead
  DB_HOST: mysql

# Speed up builds
cache:
  key: $CI_BUILD_REF_NAME # changed to $CI_COMMIT_REF_NAME in Gitlab 9.x
  paths:
    - vendor
    - node_modules
    - public
    - .yarn


test:
  stage: test
  services:
    - mysql:5.7
  image: edbizarro/gitlab-ci-pipeline-php:7.3-alpine
  script:
    - yarn config set cache-folder .yarn
    - yarn install --pure-lockfile
    - composer install --prefer-dist --no-ansi --no-interaction --no-progress
    - cp .env.example .env
    - php artisan key:generate
    - php artisan migrate:refresh --seed
    - ./vendor/phpunit/phpunit/phpunit -v --coverage-text --colors=never --stderr
  artifacts:
    paths:
      - ./storage/logs # for debugging
    expire_in: 7 days
    when: always

deploy:
  stage: deploy
  image: edbizarro/gitlab-ci-pipeline-php:7.3-alpine
  script:
    - echo "Deploy all the things!"
  only:
    - master
  when: on_success
```

#### Laravel Dusk tests ```.gitlab-ci.yml``` using mysql service and cache

```yaml
stages:
  - test

# Variables
variables:
  MYSQL_ROOT_PASSWORD: root
  MYSQL_USER: homestead
  MYSQL_PASSWORD: secret
  MYSQL_DATABASE: homestead
  DB_HOST: mysql

# Speed up builds
cache:
  key: $CI_BUILD_REF_NAME # changed to $CI_COMMIT_REF_NAME in Gitlab 9.x
  paths:
    - vendor
    - node_modules
    - public
    - .yarn


test:
  stage: test
  services:
    - mysql:5.7
  image: edbizarro/gitlab-ci-pipeline-php:7.3-chromium
  script:
    - yarn config set cache-folder .yarn
    - yarn install --pure-lockfile
    - composer install --prefer-dist --no-ansi --no-interaction --no-progress
    - cp .env.example .env
    - php artisan key:generate
    - php artisan migrate:refresh --seed
    - php artisan serve &
    - ./vendor/laravel/dusk/bin/chromedriver-linux --port=9515 &
    - sleep 5
    - php artisan dusk
  artifacts:
    paths:
      - ./storage/logs # for debugging
      - ./tests/Browser/screenshots # for Dusk screenshots
      - ./tests/Browser/console
    expire_in: 7 days
    when: always
```
---

## Deploying Laravel applications with Gitlab

Recommended

- [Deployer](https://deployer.org/blog/how-to-deploy-laravel)
- [Envoyer](https://envoyer.io)

---

Special thanks to [Ambientum](https://github.com/codecasts/ambientum), an incredible Brazilian project, for the inspiration.

Also https://github.com/Chialab/docker-php for php 7.2 build scripts

[![forthebadge](https://forthebadge.com/images/badges/fuck-it-ship-it.svg)](https://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/built-by-developers.svg)](http://forthebadge.com)
