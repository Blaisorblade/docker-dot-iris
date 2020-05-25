#
# Install the dependencies from SUBMODULE_PATH/opam
#

ARG COQ_IMAGE
FROM ${COQ_IMAGE}

ENV NJOBS="4"
ENV CONTRIB_NAME="dot-iris"
ENV SUBMODULE_PATH="dot-iris"
ENV OPAM_NAME="dot-iris-builddep"

RUN ["mkdir", "/home/coq/$OPAM_NAME/"]

COPY $SUBMODULE_PATH/opam /home/coq/$OPAM_NAME/

RUN ["/bin/bash", "--login", "-c", "set -x \
  && opam switch ${COMPILER_EDGE} \
  && opam repo add iris-dev https://gitlab.mpi-sws.org/iris/opam.git --set-default --all "]

RUN ["/bin/bash", "--login", "-c", "set -x \
  && eval $(opam env) \
  && opam update -y \
  && opam pin add -y -n -k path $OPAM_NAME $OPAM_NAME/ \
  && opam install -y -v -j ${NJOBS} --deps-only $OPAM_NAME \
  && opam clean -a -c -s --logs \
  && opam config list && opam list"]
