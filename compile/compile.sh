#!/bin/bash -x
### Recompile the code of libreoffice, according to the instructions at:
### https://wiki.ubuntu.com/BuildingLibreOffice and 
### https://wiki.documentfoundation.org/Development/How_to_build/localized

### This script assumes that the source code of LibreOffice is at ./libreoffice-5-0/
### and is already cloned with the command:
###     git clone --branch=libreoffice-5-0 git://anongit.freedesktop.org/libreoffice/core libreoffice-5-0

### defaults
default_git_branch=libreoffice-5-0
lng=sq

### make sure that the script is called with `nohup nice ...`
if [ "$1" != "calling_myself" ]
then
    # this script has *not* been called recursively by itself
    git_branch=${1:-$default_git_branch}
    datestamp=$(date +%F | tr -d -)
    nohup_out=$(dirname $0)/nohup-$git_branch-$datestamp.out
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
### and make sure that we have the right git branch
cd $(dirname $0)
git_branch=${1:-$default_git_branch}
cd $git_branch/
time git checkout $git_branch
time git pull

### start the compilation
time ./autogen.sh --without-help --without-myspell-dicts --with-lang="$lng"
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
echo "Start time: $start_time"
echo "Start time: $end_time"
echo ================================================================

