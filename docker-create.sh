#!/bin/bash
### Create the docker container.

docker create --name=libreoffice-sq --hostname=libreoffice-sq.fs.al \
    -v $(pwd)/compile:/compile \
    libreoffice-sq

