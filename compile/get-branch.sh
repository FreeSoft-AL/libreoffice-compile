#!/bin/bash -xe
### This script is useful for moving to another branch.
### It expects the git repository of libreoffice in a
### directory with the same name as the branch.
###
### Example usage:
###    cp -a libreoffice-5-0 libreoffice-5-0-0
###    ./get-branch.sh libreoffice-5-0-0

cd $(dirname $0)
branch=${1:-libreoffice-4-4-4}
cd $branch

time nice git reset
time nice git checkout .
time nice git clean -fdx
time nice ./g checkout $branch

git status
