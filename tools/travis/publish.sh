#!/bin/bash
set -eux

# Build script for Travis-CI.

SCRIPTDIR=$(cd $(dirname "$0") && pwd)
ROOTDIR="$SCRIPTDIR/../.."
WHISKDIR="$ROOTDIR/../openwhisk"

export OPENWHISK_HOME=$WHISKDIR

IMAGE_PREFIX=$1
RUNTIME_VERSION=${2:-"swift4"}
IMAGE_TAG=${3:-"latest"}

# default to swift4
RUNTIME="swift4"
if [ ${RUNTIME_VERSION} == "4.1" ]; then
  RUNTIME="swift41"
elif [ ${RUNTIME_VERSION} == "5" ]; then
  RUNTIME="swift5"
fi

if [[ ! -z ${DOCKER_USER} ]] && [[ ! -z ${DOCKER_PASSWORD} ]]; then
docker login -u "${DOCKER_USER}" -p "${DOCKER_PASSWORD}"
fi

if [[ ! -z ${RUNTIME} ]]; then
TERM=dumb ./gradlew \
:${RUNTIME}:distDocker \
-PdockerRegistry=docker.io \
-PdockerImagePrefix=${IMAGE_PREFIX} \
-PdockerImageTag=${IMAGE_TAG}
fi
