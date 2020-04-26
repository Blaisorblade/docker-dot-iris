#!/bin/bash -ex
COQ_VERSION=8.11.1
COQ_IMAGE=blaisorblade/coq:${COQ_VERSION}
VERSION=coq-${COQ_VERSION}-iris-$(grep coq-iris dot-iris/opam | sed -n 's/.*"dev\.\(.*\)".*/\1/p')

TAG=blaisorblade/docker-dot-iris:$VERSION

docker build --pull --rm \
  --build-arg COQ_IMAGE="${COQ_IMAGE}" \
  -t $TAG .

docker push $TAG
