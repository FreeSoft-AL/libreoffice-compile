#!/bin/bash
### Create the docker container.

### This script assumes that the source code of LibreOffice is
### at the directory 'libreoffice/' and is cloned with the command:
###     git clone git://anongit.freedesktop.org/libreoffice/core libreoffice

docker create --name=libreoffice-sq --hostname=libreoffice-sq.fs.al \
    -v $(pwd)/libreoffice:/libreoffice \
    libreoffice-sq

