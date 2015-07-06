# Compiling LibreOffice-Dev with the latest translations

## Create and run the container

Create and start a container like this:
```
docker/build.sh
docker/create.sh
docker start libreoffice-compile
```

To enter the container run `docker exec -it libreoffice-compile /bin/bash`.
You can also login remotely with `ssh` (using the port `2211`).


## Clone the source code of LibreOffice

These scripts assume that the code that will be compiled is already cloned inside the directory `compile/`,
and the directory has the same name as the branch that will be compiled. For example:
```
git clone --branch=libreoffice-5-0 \
          git://anongit.freedesktop.org/libreoffice/core \
          compile/libreoffice-5-0
```


## Start compilation

Edit `compile/config` and set the right git branch and language to be compiled.
Then run `docker/compile.sh`. The compilation script will use `nohup`, so you can press `Ctrl+C`
and the compilation will still continue on the background. Everything will be recorded in a log file,
and you can check it anytime like this:
```
tail -f compile/nohup-libreoffice-5-0-20150706.out
less -r compile/nohup-libreoffice-5-0-20150706.out
```
You can also start the compilation from inside the container (for example if you login with `ssh`),
like this: `/compile/compile.sh`.
Again, you can press `Ctrl+C` to stop the log display, and then resume it later with:
```
tail -f /compile/nohup-libreoffice-5-0-20150706.out
```

## Get and run the compiled program

When the compilation ends successfully, the new program will be placed inside the folder `compile/`.
You can run it like this:
```
tar xfz compile/libreoffice-5-0-20150706.tgz
libreoffice-5-0-20150706/program/soffice &
```

