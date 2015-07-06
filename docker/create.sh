#!/bin/bash
### Create the docker container.

cd $(dirname $0)
cd ..

docker create --name=libreoffice-compile \
    -p 2211:2211 \
    -v $(pwd)/compile:/compile \
    libreoffice-compile

