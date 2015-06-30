#!/bin/bash

docker create --name=libreoffice-sq --hostname=libreoffice-sq.fs.al \
    -v $(pwd)/code:/libreoffice libreoffice-sq


