# Build and test PHP applications with Gitlab CI

> Docker images with everything you'll need to build and test PHP applications on Gitlab Continous Integration (or any other CI plataform!)

![Logo](https://raw.githubusercontent.com/edbizarro/gitlab-ci-pipeline-php/master/gitlab-ci-pipeline-php.png)

---

## Based on [Official PHP images](https://hub.docker.com/_/php/)


- ```7```, ```7.2```, ```latest``` [(7.2/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.2/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.2.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.2 "Get your own image badge on microbadger.com")
- ```7.2-alpine``` [(7.2/alpine/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.2/alpine/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.2-alpine.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.2-alpine "Get your own image badge on microbadger.com")
- ```7.2-fpm```, ```fpm``` [(7.2/fpm/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.2/fpm/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.2-fpm.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.2-fpm "Get your own image badge on microbadger.com")
- ```7.1``` [(7.1/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.1/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php "Get your own image badge on microbadger.com")
- ```7.1-alpine``` [(7.1/alpine/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.1/alpine/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.1-alpine.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.1-alpine "Get your own image badge on microbadger.com")
- ```7.1-fpm``` [(7.1/fpm/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.1/fpm/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.1-fpm.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.1-fpm "Get your own image badge on microbadger.com")
- ```7.0``` [(7.0/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.0/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.0.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.0 "Get your own image badge on microbadger.com")
- ```7.0-alpine``` [(7.0/alpine/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.0/alpine/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.0-alpine.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.0-alpine "Get your own image badge on microbadger.com")
- ```7.0-fpm``` [(7.0/fpm/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/7.0/fpm/Dockerfile) - [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:7.0-fpm.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:7.0-fpm "Get your own image badge on microbadger.com")
- ```5.6``` (Deprecated*) [(5.6/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/5.6/Dockerfile) -  [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:5.6.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:5.6 "Get your own image badge on microbadger.com")
- ```5.6-fpm``` (Deprecated*) [(5.6/fpm/Dockerfile)](https://github.com/edbizarro/gitlab-ci-pipeline-php/blob/master/php/5.6/fpm/Dockerfile) -  [![](https://images.microbadger.com/badges/image/edbizarro/gitlab-ci-pipeline-php:5.6-fpm.svg)](https://microbadger.com/images/edbizarro/gitlab-ci-pipeline-php:5.6-fpm "Get your own image badge on microbadger.com")

All versions come with [Node 9](https://nodejs.org/en/), [Composer](https://getcomposer.org/) and [Yarn](https://yarnpkg.com)

> *Deprecated images won't get any update.

[![Docker Pulls](https://img.shields.io/docker/pulls/edbizarro/gitlab-ci-pipeline-php.svg?style=for-the-badge)](https://hub.docker.com/r/edbizarro/gitlab-ci-pipeline-php/)


---

### Laravel users

These images come with PHP (with all laravel required extensions), Composer (with [hirak/prestissimo](https://github.com/hirak/prestissimo) to speed up), Node and [Yarn](https://yarnpkg.com).

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
  image: edbizarro/gitlab-ci-pipeline-php:7.2-alpine
  script:
    - yarn
    - composer install --prefer-dist --no-ansi --no-interaction --no-progress
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
  image: edbizarro/gitlab-ci-pipeline-php:7.2-alpine
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
    expire_in: 1 days
    when: always

deploy:
  stage: deploy
  image: edbizarro/gitlab-ci-pipeline-php:7.1
  script:
    - echo "Deploy all the things!"
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

Also https://github.com/Chialab/docker-php for php 7.2 build scripts

[![forthebadge](http://forthebadge.com/images/badges/built-by-developers.svg)](http://forthebadge.com)
[![forthebadge](http://forthebadge.com/images/badges/powered-by-netflix.svg)](http://forthebadge.com)
