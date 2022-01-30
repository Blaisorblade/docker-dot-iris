#!/bin/bash -ex
REPO=Blaisorblade/dot-iris
#COMMIT=port-coq-813
COMMIT=c623d0149454da01dc10999681aa47fc293d2585

COQ_VERSION=8.13.0
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
