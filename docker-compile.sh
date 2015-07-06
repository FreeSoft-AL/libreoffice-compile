#!/bin/bash -x
branch=${1:-libreoffice-5-0}
docker exec -it libreoffice-sq /compile/compile.sh $branch
