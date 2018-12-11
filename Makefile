NAMESPACE=edbizarro/gitlab-ci-pipeline-php

.PHONY: pull build push

all: pull build test push

pull:
	docker pull ${NAMESPACE}:7.0-alpine || true
	docker pull ${NAMESPACE}:7.1-alpine || true
	docker pull ${NAMESPACE}:7.2-alpine || true
	docker pull ${NAMESPACE}:7.3-alpine || true
	docker pull ${NAMESPACE}:7.0-alpine-lts || true
	docker pull ${NAMESPACE}:7.1-alpine-lts || true
	docker pull ${NAMESPACE}:7.2-alpine-lts || true
	docker pull ${NAMESPACE}:7.3-alpine-lts || true

build:
	docker build --compress --cache-from ${NAMESPACE}:7.0-alpine -t ${NAMESPACE}:7.0-alpine -f php/7.0/alpine/Dockerfile .
	docker build --compress --cache-from ${NAMESPACE}:7.1-alpine -t ${NAMESPACE}:7.1-alpine -f php/7.1/alpine/Dockerfile .
	docker build --compress --cache-from ${NAMESPACE}:7.2-alpine -t ${NAMESPACE}:7.2-alpine -f php/7.2/alpine/Dockerfile .
	docker build --compress --cache-from ${NAMESPACE}:7.3-alpine -t ${NAMESPACE}:7.3-alpine -f php/7.3/alpine/Dockerfile .
	docker build --compress --cache-from ${NAMESPACE}:7.0-alpine-lts -t ${NAMESPACE}:7.0-alpine-lts -f php/7.0/alpine/Dockerfile-lts .
	docker build --compress --cache-from ${NAMESPACE}:7.1-alpine-lts -t ${NAMESPACE}:7.1-alpine-lts -f php/7.1/alpine/Dockerfile-lts .
	docker build --compress --cache-from ${NAMESPACE}:7.2-alpine-lts -t ${NAMESPACE}:7.2-alpine-lts -f php/7.2/alpine/Dockerfile-lts .
	docker build --compress --cache-from ${NAMESPACE}:7.3-alpine-lts -t ${NAMESPACE}:7.3-alpine-lts -f php/7.3/alpine/Dockerfile-lts .

test:
	docker run -t --rm -v $(PWD):/var/www/html ${NAMESPACE}:7.0-alpine goss -g goss.yaml v
	docker run -t --rm -v $(PWD):/var/www/html ${NAMESPACE}:7.1-alpine goss -g goss.yaml v
	docker run -t --rm -v $(PWD):/var/www/html ${NAMESPACE}:7.2-alpine goss -g goss-7.2.yaml v
	docker run -t --rm -v $(PWD):/var/www/html ${NAMESPACE}:7.0-alpine-lts goss -g goss-lts.yaml v
	docker run -t --rm -v $(PWD):/var/www/html ${NAMESPACE}:7.1-alpine-lts goss -g goss-lts.yaml v
	docker run -t --rm -v $(PWD):/var/www/html ${NAMESPACE}:7.2-alpine-lts goss -g goss-7.2-lts.yaml v
	docker run -t --rm -v $(PWD):/var/www/html ${NAMESPACE}:7.3-alpine-lts goss -g goss-7.2-lts.yaml v

push:
	docker tag ${NAMESPACE}:7.3-alpine ${NAMESPACE}:alpine
	docker tag ${NAMESPACE}:7.3-alpine-lts ${NAMESPACE}:alpine-lts
	docker push ${NAMESPACE}:alpine
	docker push ${NAMESPACE}:alpine-lts
	docker push ${NAMESPACE}:7.0-alpine
	docker push ${NAMESPACE}:7.1-alpine
	docker push ${NAMESPACE}:7.2-alpine
	docker push ${NAMESPACE}:7.3-alpine
	docker push ${NAMESPACE}:7.0-alpine-lts
	docker push ${NAMESPACE}:7.1-alpine-lts
	docker push ${NAMESPACE}:7.2-alpine-lts
	docker push ${NAMESPACE}:7.3-alpine-lts
