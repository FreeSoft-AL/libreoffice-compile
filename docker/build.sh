#!/bin/bash
# this uses Dockerfile

cd $(dirname $0)
docker build --tag=libreoffice-compile .

