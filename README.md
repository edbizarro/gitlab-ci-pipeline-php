# Build and test PHP applications with Gitlab CI

> Docker images with everything you'll need to build and test PHP applications on Gitlab Continous Integration

![Logo](https://raw.githubusercontent.com/edbizarro/gitlab-ci-pipeline-php/master/gitlab-ci-pipeline-php.png)

---

## Based on [Official PHP images](https://hub.docker.com/_/php/)


- ```7```, ```7.1```, ```latest``` [(7.1/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.1/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php "Get your own image badge on microbadger.com")
- ```7.1-alpine``` [(7.1/alpine/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.1/alpine/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.1-alpine.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.1-alpine "Get your own image badge on microbadger.com")
- ```7.1-fpm```, ```fpm``` [(7.1/fpm/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.1/fpm/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.1-fpm.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.1-fpm "Get your own image badge on microbadger.com")
- ```7.0``` [(7.0/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.0/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.0.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.0 "Get your own image badge on microbadger.com")
- ```7.0-alpine``` [(7.0/alpine/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.0/alpine/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.0-alpine.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.0-alpine "Get your own image badge on microbadger.com")
- ```7.0-fpm``` [(7.0/fpm/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.0/fpm/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.0-fpm.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.0-fpm "Get your own image badge on microbadger.com")
- ```5.6``` [(5.6/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/5.6/Dockerfile) -  [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:5.6.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:5.6 "Get your own image badge on microbadger.com")
- ```5.6-fpm``` [(5.6/fpm/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/5.6/fpm/Dockerfile) -  [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:5.6-fpm.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:5.6-fpm "Get your own image badge on microbadger.com")

Debian versions come with Node 8.x, Alpine versions come with Node 6.x. All versions come with composer and [yarn](https://yarnpkg.com)

[![Build Status](https://semaphoreci.com/api/v1/edbizarro/gitlab-ci-pipeline-php/branches/master/badge.svg)](https://semaphoreci.com/edbizarro/gitlab-ci-pipeline-php)

---

### Laravel users

These images come with PHP (with all laravel required extensions), Composer (with [hirak/prestissimo](https://github.com/hirak/prestissimo) to speed up), Node 8.x and [Yarn](https://yarnpkg.com).

Everything you need to test Laravel projects :D

---

## Gitlab pipeline examples

Laravel test examples

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
  image: edbizarro/gitlab-ci-pipeline-php:7.1-alpine
  script:
    - yarn
    - composer install --prefer-dist --no-ansi --no-interaction --no-progress --no-scripts
    - cp .env.example .env
    - php artisan key:generate
    - php artisan migrate:refresh --seed
    - ./vendor/phpunit/phpunit/phpunit -v --coverage-text --colors=never --stderr
```

### Advanced ```.gitlab-ci.yml``` using mysql service, stages and cache

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
  image: edbizarro/gitlab-ci-pipeline-php:7.1-alpine
  script:
    - yarn config set cache-folder .yarn
    - yarn install --pure-lockfile
    - composer install --prefer-dist --no-ansi --no-interaction --no-progress --no-scripts
    - cp .env.example .env
    - php artisan key:generate
    - php artisan migrate:refresh --seed
    - ./vendor/phpunit/phpunit/phpunit -v --coverage-text --colors=never --stderr
  artifacts:
    paths:
      - ./storage/logs # for debugging
    expire_in: 1 days
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

## Deploying Laravel applications with Gitlab

Recommended

- [Deployer](https://deployer.org/blog/how-to-deploy-laravel)
- [Envoyer](https://envoyer.io)

---

Special thanks to [Ambientum](https://github.com/codecasts/ambientum), an incredible Brazilian project, for the inspiration.

[![forthebadge](http://forthebadge.com/images/badges/built-by-developers.svg)](http://forthebadge.com)
