FROM edbizarro/gitlab-ci-pipeline-php:8.0

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Eduardo Bizarro <edbizarro@gmail.com>" \
  PHP="8.0" \
  NODE="14" \
  org.label-schema.name="edbizarro/gitlab-ci-pipeline-php" \
  org.label-schema.description=":coffee: Docker images for build and test PHP applications with Gitlab CI (or any other CI plataform!)" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.schema-version="1.0" \
  org.label-schema.vcs-url="https://github.com/edbizarro/gitlab-ci-pipeline-php" \
  org.label-schema.vcs-ref=$VCS_REF

# Set correct environment variables
ENV IMAGE_USER=php
ENV HOME=/home/$IMAGE_USER
ENV COMPOSER_HOME=$HOME/.composer
ENV PATH=$HOME/.yarn/bin:$PATH
ENV GOSS_VERSION="0.3.8"
ENV PHP_VERSION=8.0

USER root

WORKDIR /tmp

COPY ./php/scripts/*.sh /tmp/
RUN chmod +x /tmp/*.sh

RUN bash ./packages.sh \
  && bash ./chromium.sh

USER $IMAGE_USER

WORKDIR /var/www/html
