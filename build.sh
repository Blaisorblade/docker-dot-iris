#!/bin/bash
VERSION=coq-8.11-dev-iris-$(grep coq-iris dot-iris/opam | sed -n 's/.*"dev\.\(.*\)".*/\1/p')

TAG=blaisorblade/docker-dot-iris:$VERSION

docker build --pull -t $TAG .
docker push $TAG
