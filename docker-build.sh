#!/bin/bash

cd $(dirname $0)
docker build --tag=libreoffice-sq .

