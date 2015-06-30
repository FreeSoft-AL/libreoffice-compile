#!/bin/bash -x

cd $(dirname $0)

docker stop libreoffice-sq
docker rm libreoffice-sq
docker rmi libreoffice-sq

