#!/bin/bash -x

cd $(dirname $0)

docker stop libreoffice-compile
docker rm libreoffice-compile
docker rmi libreoffice-compile

