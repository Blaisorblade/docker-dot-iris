#!/bin/bash -ex
COQ_VERSION=8.11.2
COQ_IMAGE=coqorg/coq:${COQ_VERSION}
version_line=$(grep '"coq-iris"' dot-iris/opam)
iris_version=$(echo $version_line | sed -E -n 's/.*"(dev\.)?(.*)".*/\2/p')
VERSION=coq-${COQ_VERSION}-iris-${iris_version}

TAG=blaisorblade/docker-dot-iris:$VERSION

docker build --pull --rm \
  --build-arg COQ_IMAGE="${COQ_IMAGE}" \
  -t $TAG .

docker push $TAG
