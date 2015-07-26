#!/bin/bash -x
### Recompile the code of libreoffice, according to the instructions at:
### https://wiki.ubuntu.com/BuildingLibreOffice and 
### https://wiki.documentfoundation.org/Development/How_to_build/localized

### got the directory of the script
cd $(dirname $0)

### get the git_branch and lang
source ./config

### make sure that the script is called with `nohup nice ...`
if [ "$1" != "calling_myself" ]
then
    # this script has *not* been called recursively by itself
    datestamp=$(date +%F | tr -d -)
    nohup_out=nohup-$git_branch-$datestamp.out
    rm -f $nohup_out
    nohup nice "$0" "calling_myself" "$@" > $nohup_out &
    sleep 1
    tail -f $nohup_out
    exit
else
    # this script has been called recursively by itself
    shift # remove the termination condition flag in $1
fi

### make sure that ccache is enabled
export CCACHE_DIR=${HOME}/.ccache_upstream
export CCACHE_BASEDIR=`readlink -f .`
ccache -M10G

### get the start time
start_time=$(date)

### stop on error
set -e

### go to the source directory
### and make sure that we have the latest version
cd $git_branch/
time ./g pull -r

### start the compilation
time ./autogen.sh --without-help --without-myspell-dicts --with-lang="$lang"
time make
time make check

### create an archive with the compiled program
set +e
datestamp=$(date +%F | tr -d -)
name="$git_branch-$datestamp"
mv instdir $name
tar cfz $name.tgz $name
mv $name.tgz ../
rm -rf $name

### get the end time
end_time=$(date)

### print the start and end times
set +x
echo ================================================================
echo "Start time : $start_time"
echo "End time   : $end_time"
echo ================================================================

