#!/bin/bash -x
### Recompile the code of libreoffice, according to the instruction at:
### https://wiki.ubuntu.com/BuildingLibreOffice and 
### https://wiki.documentfoundation.org/Development/How_to_build/localized

export CCACHE_DIR=${HOME}/.ccache_upstream
export CCACHE_BASEDIR=`readlink -f .`
ccache -M10G

cd /libreoffice/
git checkout libreoffice-5-0

./autogen.sh --without-help --without-myspell-dicts --with-lang="de sq"
make
make check

