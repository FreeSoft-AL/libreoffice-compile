#!/bin/bash -x
### Start compilation.

### go to the script directory
cd $(dirname $0)

### edit the config file
nano compile/config

### start the compilation
docker exec -it libreoffice-compile /compile/compile.sh

### show instructions on how to check the log files
set +x
source compile/config
nohup_file=$(pwd)/$(ls compile/nohup-$git_branch*.out | tail -n 1)
echo "
Check the status of compilation at any time with:

    tail -f $nohup_file
or
    less -r $nohup_file

"
