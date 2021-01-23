#!/bin/bash -ex
REPO=Blaisorblade/dot-iris
COMMIT=master

COQ_VERSION=8.11.2
COQ_IMAGE=coqorg/coq:${COQ_VERSION}
OPAM_FILE=dot-iris-opam

wget https://raw.githubusercontent.com/$REPO/$COMMIT/opam -O ${OPAM_FILE}

version_line=$(grep '"coq-iris"' ${OPAM_FILE})
iris_version=$(echo $version_line | sed -E -n 's/.*"(dev\.)?(.*)".*/\2/p')
VERSION=coq-${COQ_VERSION}-iris-${iris_version}

TAG=blaisorblade/docker-dot-iris:$VERSION

docker build --pull --rm \
  --build-arg COQ_IMAGE="${COQ_IMAGE}" \
  --build-arg OPAM_FILE="${OPAM_FILE}" \
  -t $TAG .

docker push $TAG
