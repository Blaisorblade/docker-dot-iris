#
# Install the dependencies from SUBMODULE_PATH/opam
#

ARG COQ_VERSION
FROM coqorg/coq:${COQ_VERSION}-ocaml-4.14.0-flambda

ENV NJOBS="4"

RUN set -x \
  && opam repo add iris-dev https://gitlab.mpi-sws.org/iris/opam.git --set-default --all

COPY opam-clean.sh /tmp/

ARG IRIS_VERSION
RUN set -x \
  && eval `opam env` \
  && opam update -y \
  && opam pin add -y -n -k version coq-iris ${IRIS_VERSION} \
  && opam pin add -y -n -k version coq-autosubst 1.7 \
  && opam install -y -v -j ${NJOBS} coq-iris coq-autosubst \
  && /tmp/opam-clean.sh \
  && opam config list && opam list
