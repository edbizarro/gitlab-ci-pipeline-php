# Build and test PHP applications with Gitlab CI Pipeline

[![Build Status](https://travis-ci.org/edbizarro/gitlab-ci-pipeline-php.svg?branch=master)](https://travis-ci.org/edbizarro/gitlab-ci-pipeline-php) Docker image with everything you'll need to build and test PHP applications on GITLAB CI

![Logo](https://raw.githubusercontent.com/edbizarro/gitlab-ci-pipeline-php/master/gitlab-ci-pipeline-php.png)

---

## Based on [Official PHP images](https://hub.docker.com/_/php/)


- ```7.1```, ```latest``` [(7.1/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.1/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php "Get your own image badge on microbadger.com")
- ```7.0``` [(7.0/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.0/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.0.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.0 "Get your own image badge on microbadger.com")
- ```5.6``` [(5.6/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/5.6/Dockerfile) -  [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:5.6.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:5.6 "Get your own image badge on microbadger.com")


All versions come with Node 7.x, composer and [yarn](https://yarnpkg.com)

---

### Laravel users

These images come with PHP (with all laravel required extensions), Composer, Node 7.x and [yarn](https://yarnpkg.com).

Everything you need to test Laravel projects :D

---

## Gitlab pipeline examples

### Simple ```.gitlab-ci.yml``` using mysql service

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
  image: edbizarro/gitlab-ci-pipeline-php:7.1
  script:
    - yarn clean
    - yarn
    - gulp
    - composer install --prefer-dist --no-ansi --no-interaction --no-progress --no-scripts
    - cp .env.example .env
    - php artisan key:generate
    - php artisan config:clear
    - php artisan migrate:refresh --seed
    - php artisan serve >/dev/null 2>&1 & # for API testing
    - ./vendor/phpunit/phpunit/phpunit -v --coverage-text --colors=never --stderr
```

### Advanced ```.gitlab-ci.yml``` using mysql service

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
  key: $CI_BUILD_REF_NAME
  paths:
    - vendor
    - node_modules
    - public
    - ~/.composer/cache/files
    - ~/.yarn-cache

test:
  stage: test
  services:
    - mysql:5.7
  image: edbizarro/gitlab-ci-pipeline-php:7.1
  script:
    - yarn clean
    - yarn
    - gulp
    - composer install --prefer-dist --no-ansi --no-interaction --no-progress --no-scripts
    - cp .env.example .env
    - php artisan key:generate
    - php artisan config:clear
    - php artisan migrate:refresh --seed
    - php artisan serve >/dev/null 2>&1 & # for API testing
    - ./vendor/phpunit/phpunit/phpunit -v --coverage-text --colors=never --stderr
  artifacts:
    paths:
      - ./storage/logs
    expire_in: 7 days
    when: always

deploy:
  stage: deploy
  image: edbizarro/gitlab-ci-pipeline-php:7.1
  script:
    - echo "Your deploy script"
  only:
    - master
  when: on_success
```

---

Special thanks to [Ambientum](https://github.com/codecasts/ambientum), an incredible brazilian project for the [build](https://github.com/codecasts/ambientum/blob/master/build.sh) script.

[![forthebadge](http://forthebadge.com/images/badges/built-by-developers.svg)](http://forthebadge.com)
