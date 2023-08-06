# docker-dot-iris

Build Docker images containing all dependencies for a Coq project (here `dot-iris`) — extracted from `dot-iris`'s `opam` file.
The goal is to speed up CI testing of that project, by preinstalling all the needed dependencies.

This script is currently specialized to my needs. Docs below are partially out-of-date.

## Rough workflow 

1. setup Docker
 - install Docker
 - on Mac or Windows, increase the amount of RAM assigned to the VM to avoid OOM — >= 1 GB per core should work.
 - login to Docker Hub, and login on it, so that `docker push` works (our scripts assume `docker` can be invoked without `sudo`, as on Mac, or with sudoless Docker on Linux)
2. clone this repo;
3. update the matrix of Coq/Iris versions to support in .github/workflows/docker.yml.
4. configure secrets in CI so that secrets.DOCKERHUB_USERNAME and secrets.DOCKERHUB_TOKEN allow Docker Hub access.
5. to actually push the image, you must currently merge a change, because of `push: ${{ github.event_name != 'pull_request' }}`.

## Installing Docker on Mac

I use
```
brew cask info docker
```
