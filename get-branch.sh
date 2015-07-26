#!/bin/bash -x

### First move the code of an old branch to a new branch like this:
###    cp -a compile/libreoffice-5-0 compile/libreoffice-5-0-0
### Then run:
###    ./get-branch.sh libreoffice-5-0-0

branch=${1:-libreoffice-5-0-0}

docker exec -it libreoffice-compile /compile/get-branch.sh $branch
