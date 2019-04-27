# Build and test PHP applications with Gitlab CI (or any other CI plataform!

> Docker images with everything you'll need to build and test PHP applications.

![Logo](https://raw.githubusercontent.com/edbizarro/gitlab-ci-pipeline-php/master/gitlab-ci-pipeline-php.png)

---
![GitHub last commit](https://img.shields.io/github/last-commit/edbizarro/gitlab-ci-pipeline-php.svg?style=for-the-badge&logo=git) [![Docker Pulls](https://img.shields.io/docker/pulls/edbizarro/gitlab-ci-pipeline-php.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/edbizarro/gitlab-ci-pipeline-php/) [![building status](https://gitlab.com/edbizarro/gitlab-ci-pipeline-php/badges/master/pipeline.svg)](https://gitlab.com/edbizarro/gitlab-ci-pipeline-php/commits/master)

---

## Based on [Official PHP images](https://hub.docker.com/_/php/)



- ```7```, ```7.3```, ```latest``` [(7.3/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.3/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.3.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.3 "Get your own image badge on microbadger.com")
- ```7.3-alpine```, ```alpine``` [(7.3/alpine/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.3/alpine/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.3-alpine.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.3-alpine "Get your own image badge on microbadger.com")
- ```7.3-alpine-lts```, ```alpine-lts``` [(7.3/alpine/Dockerfile-lts)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.3/alpine/Dockerfile-lts) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.3-alpine-lts.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.3-alpine-lts "Get your own image badge on microbadger.com")
- ```7.3-fpm```, ```fpm``` [(7.3/fpm/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.3/fpm/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.3-fpm.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.3-fpm "Get your own image badge on microbadger.com")
- ```7.2``` [(7.2/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.2/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.2.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.2 "Get your own image badge on microbadger.com")
- ```7.2-alpine``` [(7.2/alpine/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.2/alpine/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.2-alpine.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.2-alpine "Get your own image badge on microbadger.com")
- ```7.2-alpine-lts``` [(7.2/alpine/Dockerfile-lts)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.2/alpine/Dockerfile-lts) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.2-alpine-lts.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.2-alpine-lts "Get your own image badge on microbadger.com")
- ```7.2-fpm``` [(7.2/fpm/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.2/fpm/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.2-fpm.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.2-fpm "Get your own image badge on microbadger.com")
- ```7.1``` [(7.1/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.1/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php "Get your own image badge on microbadger.com")
- ```7.1-alpine``` [(7.1/alpine/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.1/alpine/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.1-alpine.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.1-alpine "Get your own image badge on microbadger.com")
- ```7.1-alpine-lts``` [(7.1/alpine/Dockerfile-lts)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.1/alpine/Dockerfile-lts) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.1-alpine-lts.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.1-alpine-lts "Get your own image badge on microbadger.com")
- ```7.1-fpm``` [(7.1/fpm/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.1/fpm/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.1-fpm.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.1-fpm "Get your own image badge on microbadger.com")

All versions (except `lts`) come with [Node 12](https://nodejs.org/en/), [Composer](https://getcomposer.org/) and [Yarn](https://yarnpkg.com)

> `lts` version come with node v10

>> PHP 7.0.x is now deprecated and removed from this documentation. Your scripts will not stop working since the images are still available but they will not be receiving new builds from now on.

---

## Laravel users

All images come with PHP (with all laravel required extensions), Composer (with [hirak/prestissimo](https://github.com/hirak/prestissimo) to speed up installs), Node and [Yarn](https://yarnpkg.com).

Everything you need to test Laravel projects :D

### Laravel Dusk

To run Dusk tests we need chromium installed on the image, because of that we have a special tag for this case.

- ```7.3-chromium``` [(7.3/chromium/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.3/chromium/Dockerfile) [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.3-chromium.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.3-chromium "Get your own image badge on microbadger.com")
- ```7.2-chromium``` [(7.2/chromium/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.2/chromium/Dockerfile) [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.2-chromium.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.2-chromium "Get your own image badge on microbadger.com")
- ```7.1-chromium``` [(7.1/chromium/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.1/chromium/Dockerfile) [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.1-chromium.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.1-chromium "Get your own image badge on microbadger.com")

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
    - yarn
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
    - sudo yarn config set cache-folder .yarn
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
