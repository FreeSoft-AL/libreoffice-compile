#!/bin/bash -x

### customize the shell prompt
echo libreoffice-sq > /etc/debian_chroot
sed -i /root/.bashrc \
    -e '/^#force_color_prompt=/c force_color_prompt=yes'
PS1='\\n\\[\\033[01;32m\\]${debian_chroot:+($debian_chroot)}\\[\\033[00m\\]\\u@\\h\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\e[32m\\]\\n==> \\$ \\[\\033[00m\\]'
sed -i /root/.bashrc \
    -e "/^if \[ \"\$color_prompt\" = yes \]/,+2 s/PS1=.*/PS1='$PS1'/"

### install sshd
apt-get -y install openssh-server

### create a run dir for sshd
mkdir /var/run/sshd
chmod 755 /var/run/sshd

### customize the configuration of sshd
sed -i /etc/ssh/sshd_config \
    -e 's/^Port/#Port/' \
    -e 's/^PermitRootLogin/#PermitRootLogin/' \
    -e 's/^PasswordAuthentication/#PasswordAuthentication/' \
    -e 's/^X11Forwarding/#X11Forwarding/' \
    -e 's/^UseLogin/#UseLogin/'

sed -i /etc/ssh/sshd_config \
    -e '/^### p2p config/,$ d'

cat <<EOF >> /etc/ssh/sshd_config
### p2p config
Port 2211
PermitRootLogin without-password
PasswordAuthentication no
X11Forwarding no
UseLogin no
EOF


### copy config files over to the system
dir=$(dirname $0)
cp -TdR $dir/sysconfig/ /

