NAMESPACE=edbizarro/gitlab-ci-pipeline-php

.PHONY: pull
.PHONY: push
.PHONY: build

all: pull build test

pull:
	docker pull ${NAMESPACE}:7.0
	docker pull ${NAMESPACE}:7.1
	docker pull ${NAMESPACE}:7.2
	docker pull ${NAMESPACE}:7.0-fpm
	docker pull ${NAMESPACE}:7.1-fpm
	docker pull ${NAMESPACE}:7.2-fpm
	docker pull ${NAMESPACE}:7.0-alpine
	docker pull ${NAMESPACE}:7.1-alpine
	docker pull ${NAMESPACE}:7.2-alpine
	docker pull ${NAMESPACE}:7.0-alpine-lts
	docker pull ${NAMESPACE}:7.1-alpine-lts
	docker pull ${NAMESPACE}:7.2-alpine-lts

build:
	docker build --compress --cache-from ${NAMESPACE}:7.0 -t ${NAMESPACE}:7.0 -f php/7.0/Dockerfile .
	docker build --compress --cache-from ${NAMESPACE}:7.1 -t ${NAMESPACE}:7.1 -f php/7.1/Dockerfile .
	docker build --compress --cache-from ${NAMESPACE}:7.2 -t ${NAMESPACE}:7.2 -f php/7.2/Dockerfile .
	docker build --compress --cache-from ${NAMESPACE}:7.0-fpm -t ${NAMESPACE}:7.0-fpm -f php/7.0/fpm/Dockerfile .
	docker build --compress --cache-from ${NAMESPACE}:7.1-fpm -t ${NAMESPACE}:7.1-fpm -f php/7.1/fpm/Dockerfile .
	docker build --compress --cache-from ${NAMESPACE}:7.2-fpm -t ${NAMESPACE}:7.2-fpm -f php/7.2/fpm/Dockerfile .
	docker build --compress --cache-from ${NAMESPACE}:7.0-alpine -t ${NAMESPACE}:7.0-alpine -f php/7.0/alpine/Dockerfile .
	docker build --compress --cache-from ${NAMESPACE}:7.1-alpine -t ${NAMESPACE}:7.1-alpine -f php/7.1/alpine/Dockerfile .
	docker build --compress --cache-from ${NAMESPACE}:7.2-alpine -t ${NAMESPACE}:7.2-alpine -f php/7.2/alpine/Dockerfile .
	docker build --compress --cache-from ${NAMESPACE}:7.0-alpine-lts -t ${NAMESPACE}:7.0-alpine-lts -f php/7.0/alpine/Dockerfile-lts .
	docker build --compress --cache-from ${NAMESPACE}:7.1-alpine-lts -t ${NAMESPACE}:7.1-alpine-lts -f php/7.1/alpine/Dockerfile-lts .
	docker build --compress --cache-from ${NAMESPACE}:7.2-alpine-lts -t ${NAMESPACE}:7.2-alpine-lts -f php/7.2/alpine/Dockerfile-lts .

test:
	docker run -t --rm -v $(pwd):/var/www/html ${NAMESPACE}:7.0 goss -g goss.yaml v
	docker run -t --rm -v $(pwd):/var/www/html ${NAMESPACE}:7.1 goss -g goss.yaml v
	docker run -t --rm -v $(pwd):/var/www/html ${NAMESPACE}:7.2 goss -g goss-7.2.yaml v
	docker run -t --rm -v $(pwd):/var/www/html ${NAMESPACE}:7.0-fpm goss -g goss.yaml v
	docker run -t --rm -v $(pwd):/var/www/html ${NAMESPACE}:7.1-fpm goss -g goss.yaml v
	docker run -t --rm -v $(pwd):/var/www/html ${NAMESPACE}:7.2-fpm goss -g goss-7.2.yaml v
	docker run -t --rm -v $(pwd):/var/www/html ${NAMESPACE}:7.0-alpine goss -g goss.yaml v
	docker run -t --rm -v $(pwd):/var/www/html ${NAMESPACE}:7.1-alpine goss -g goss.yaml v
	docker run -t --rm -v $(pwd):/var/www/html ${NAMESPACE}:7.2-alpine goss -g goss-7.2.yaml v
	docker run -t --rm -v $(pwd):/var/www/html ${NAMESPACE}:7.0-alpine-lts goss -g goss-lts.yaml v
	docker run -t --rm -v $(pwd):/var/www/html ${NAMESPACE}:7.1-alpine-lts goss -g goss-lts.yaml v
	docker run -t --rm -v $(pwd):/var/www/html ${NAMESPACE}:7.2-alpine-lts goss -g goss-7.2-lts.yaml v

push:
	docker tag ${NAMESPACE}:7.2 ${NAMESPACE}:latest
	docker tag ${NAMESPACE}:7.2 ${NAMESPACE}:7
	docker tag ${NAMESPACE}:7.2-fpm ${NAMESPACE}:fpm
	docker tag ${NAMESPACE}:7.2-alpine ${NAMESPACE}:alpine
	docker tag ${NAMESPACE}:7.2-alpine-lts ${NAMESPACE}:alpine-lts
	docker push ${NAMESPACE}:latest
	docker push ${NAMESPACE}:7
	docker push ${NAMESPACE}:fpm
	docker push ${NAMESPACE}:alpine
	docker push ${NAMESPACE}:alpine-lts
	docker push ${NAMESPACE}:7.0
	docker push ${NAMESPACE}:7.1
	docker push ${NAMESPACE}:7.2
	docker push ${NAMESPACE}:7.0-fpm
	docker push ${NAMESPACE}:7.1-fpm
	docker push ${NAMESPACE}:7.2-fpm
	docker push ${NAMESPACE}:7.0-alpine
	docker push ${NAMESPACE}:7.1-alpine
	docker push ${NAMESPACE}:7.2-alpine
	docker push ${NAMESPACE}:7.0-alpine-lts
	docker push ${NAMESPACE}:7.1-alpine-lts
	docker push ${NAMESPACE}:7.2-alpine-lts
