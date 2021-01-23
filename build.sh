#!/bin/bash -ex
REPO=Blaisorblade/dot-iris
#COMMIT=port-coq-812
COMMIT=52c6daef0a8573b7e19371a5dadd2a36276d6aed

COQ_VERSION=8.12.1
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
