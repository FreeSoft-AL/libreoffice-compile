# libreoffice-sq

Scripts for building a Docker image for compiling LibreOffice with the latest Albanian translations.

They assume that the code of LibreOffice is already cloned at some directory, for example:
```
git clone git://anongit.freedesktop.org/libreoffice/core /var/libreoffice
```

The symbolic link in this directory should point to it, for example:
```
ln -s /var/libreoffice libreoffice
```
This directory will be mounted inside the container at `/libreoffice`.

Then create and start a container like this:
```
./docker-build.sh
./docker-create.sh
docker start libreoffice-sq
```

To enter the container run `docker exec -it libreoffice-sq /bin/bash`.

Inside the container, run the script `compile.sh` with a certain branch name, for example:
```
./compile.sh libreoffice-4-4-4
./compile.sh libreoffice-5-0
```

You will notice that some `nohup` files will be created, which have the logs of compilation process.
Check them like this:
```
tail -f nohup-20150704-libreoffice-4-4-4.out
less -r nohup-20150704-libreoffice-4-4-4.out
```

When the compilation ends up successfully, the new program is at `/libreoffice/instdir/program/soffice`.
