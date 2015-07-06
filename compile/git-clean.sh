#!/bin/bash -xe
### This script is useful before moving to another branch.
### It will also erase ccache data!

cd $(dirname $0)
dir=${1:-libreoffice-4-4-4}
cd $dir

time nice git reset
time nice git checkout .
time nice git clean -fdx
time nice git checkout master
time nice git pull

git status
