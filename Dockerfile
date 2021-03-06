#
# Install the dependencies from SUBMODULE_PATH/opam
#

ARG COQ_IMAGE
# Clears COQ_IMAGE
FROM ${COQ_IMAGE}
# Must be after FROM
ARG OPAM_FILE

ENV NJOBS="4"
ENV OPAM_NAME="dot-iris-builddep"

COPY $OPAM_FILE /home/coq/$OPAM_NAME/opam
COPY opam-clean.sh /tmp/

RUN ["/bin/bash", "--login", "-c", "set -x \
  && opam switch ${COMPILER_EDGE} \
  && opam repo add iris-dev https://gitlab.mpi-sws.org/iris/opam.git --set-default --all "]

RUN ["/bin/bash", "--login", "-c", "set -x \
  && eval $(opam env) \
  && opam update -y \
  && opam pin add -y -n -k path $OPAM_NAME $OPAM_NAME/ \
  && opam install -y -v -j ${NJOBS} --deps-only $OPAM_NAME \
  && /tmp/opam-clean.sh \
  && opam config list && opam list"]
