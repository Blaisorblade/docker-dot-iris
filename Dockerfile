#
# Install the dependencies from SUBMODULE_PATH/opam
#

FROM coqorg/coq:8.15-ocaml-4.12-flambda

ENV NJOBS="4"

RUN set -x \
  && opam repo add iris-dev https://gitlab.mpi-sws.org/iris/opam.git --set-default --all

COPY opam-clean.sh /tmp/

RUN set -x \
  && eval `opam env` \
  && opam update -y \
  && opam pin add -y -n -k version coq-iris 3.6.0 \
  && opam pin add -y -n -k version coq-autosubst 1.7 \
  && opam install -y -v -j ${NJOBS} coq-iris coq-autosubst \
  && /tmp/opam-clean.sh \
  && opam config list && opam list
