# docker-dot-iris

Build Docker images containing all dependencies for a Coq project (here `dot-iris`) — extracted from `dot-iris`'s `opam` file.
The goal is to speed up CI testing of that project, by preinstalling all the needed dependencies.

This script is currently specialized to my needs.

## Rough workflow 

1. setup Docker
 - install Docker
 - login to Docker Hub, and login on it, so that `docker push` works (our scripts assume `docker` can be invoked without `sudo`, as on Mac, or with sudoless Docker on Linux)
2. clone this repo;
3. initialize the `dot-iris` submodule;
4. if needed, bump the dependency versions of the `dot-iris` submodule (and create a PR for bumping dependencies);
5. review `build.sh` and `Dockerfile` for defaults to configure, such as
  - Coq version (`COQ_VERSION` in `build.sh`, currently `8.11.2`)
  - Docker username and image name (`TAG` in `build.sh`)
  - number of parallel jobs for builds inside Docker (`NJOBS` in `Dockerfile`, currently `4`)
6. run `build.sh`, which will:
  - build a Docker image containing all dependencies for `dot-iris`
  - tag it, with a name mentioning the versions used for the Coq and Iris dependencies
  - push it to Docker Hub using `docker push`
7. if in step 4 you bumped dependencies and created a PR, modify `.travis.yml` in that PR to use the newly built Docker image.
