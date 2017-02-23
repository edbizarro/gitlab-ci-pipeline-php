#!/bin/bash

# resulting images namespace on docker hub
NAMESPACE=edbizarro/gitlab-ci-pipeline

# publish the built images
PUBLISH=true

# enabled repositories for the build
REPOSITORIES=$1

# enable all repositories if any specified
if [[ -z $REPOSITORIES ]]; then
    REPOSITORIES="php"
fi

# for returning later to the main directory
ROOT_DIRECTORY=`pwd`

# function for building images
function build_repository {
    # read repository configuration
    source $ROOT_DIRECTORY/$REPOSITORY/buildvars

    # build all enabled versions
    for TAG in $TAGS; do
      # some verbose
      echo $'\n\n'"--> Building $NAMESPACE-$REPOSITORY:$TAG"$'\n'
      docker build -t $NAMESPACE-$REPOSITORY:$TAG -f $ROOT_DIRECTORY/$REPOSITORY/$TAG/Dockerfile .

      if [ -d "$ROOT_DIRECTORY/$REPOSITORY/$TAG/$VARIANT" ]; then
        echo $'\n\n'"--> Building variant $NAMESPACE-$REPOSITORY:$TAG-$VARIANT"$'\n'
        docker build -t $NAMESPACE-$REPOSITORY:$TAG-$VARIANT -f $ROOT_DIRECTORY/$REPOSITORY/$TAG/$VARIANT/Dockerfile .
      fi
    done

    # create the latest tag
    echo $'\n\n'"--> Aliasing $LATEST as 'latest'"$'\n'
    docker tag $NAMESPACE-$REPOSITORY:$LATEST $NAMESPACE-$REPOSITORY:latest
}

# function for publishing images
function publish_repository {
    # read repository configuration
    source $ROOT_DIRECTORY/$REPOSITORY/buildvars

    # publish all enabled versions
    for TAG in $TAGS; do
      # some verbose
      echo $'\n\n'"--> Publishing $NAMESPACE-$REPOSITORY:$TAG"$'\n'
      # publish
      docker push $NAMESPACE-$REPOSITORY:$TAG

      if [ -d "$ROOT_DIRECTORY/$REPOSITORY/$TAG/$VARIANT" ]; then
        echo $'\n\n'"--> Building variant $NAMESPACE-$REPOSITORY:$TAG-$VARIANT"$'\n'
        docker push $NAMESPACE-$REPOSITORY:$TAG-$VARIANT
      fi
    done

    # create the latest tag
    echo $'\n\n'"--> Publishing $NAMESPACE-$REPOSITORY:latest (from $LATEST)"$'\n'
    docker push $NAMESPACE-$REPOSITORY:latest
}

# for each enabled repository
for REPOSITORY in $REPOSITORIES; do
  # build the repository
  build_repository $REPOSITORY

  # If publishing is enabled
  if [ $PUBLISH == true ]; then
    # Push the built image
    publish_repository $REPOSITORY
  fi
done

curl -XPOST https://hooks.microbadger.com/images/edbizarro/gitlab-ci-pipeline-php/rDYTTzaY7CxoUFxH5jqjPLS3Lyk=
