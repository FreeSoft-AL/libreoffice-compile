#!/bin/bash -x
### Start compilation.

cd $(dirname $0)

nano compile/config

docker exec -it libreoffice-compile /compile/compile.sh

set +x
nohup_file=$(pwd)/$(ls compile/nohup-*.out | tail -n 1)
echo "
Check the status of compilation at any time with:

    tail -f $nohup_file
or
    less -r $nohup_file

"
