#!/bin/sh
VERSION=2020-01-21.1.676a5302

TAG=blaisorblade/docker-dot-iris:$VERSION

docker build -t $TAG .
docker push $TAG
