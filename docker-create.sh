#!/bin/bash
### Create the docker container.

docker create --name=libreoffice-sq --hostname=libreoffice-sq.fs.al \
    -p 2211:2211 \
    -v $(pwd)/compile:/compile \
    libreoffice-sq

