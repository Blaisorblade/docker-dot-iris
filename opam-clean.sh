#!/bin/sh
opamPrefix=`opam config var prefix`
# To shrink the image, we use opam clean to remove build folders and the repository cache from opam update.
# Some are kept by default because of https://github.com/ocaml/opam/issues/4255
opam clean -a -c -s --logs -r

# However, there is more stuff that we can remove; some of this will break `opam upgrade`, but we don't care.
rm -rf ~/.opam/download-cache
# Actual contents of the repositories, can be redownloaded
rm -rf ~/.opam/repo/*/
rm -rf ${opamPrefix}/.opam-switch/sources