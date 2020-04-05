#!/bin/bash -ex
COQ_VERSION=8.10.2
COQ_IMAGE=coqorg/coq:8.10
VERSION=coq-${COQ_VERSION}-iris-$(grep coq-iris dot-iris/opam | sed -n 's/.*"dev\.\(.*\)".*/\1/p')

TAG=blaisorblade/docker-dot-iris:$VERSION

docker build --pull --rm \
  --build-arg COQ_IMAGE="${COQ_IMAGE}" \
  -t $TAG .

docker push $TAG
