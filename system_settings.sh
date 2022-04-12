#!/bin/bash

export DEBIAN_FRONTEND=dialog
export TERM=xterm-color


# turn off translations, speed up apt update
#mkdir -p /etc/apt/apt.conf.d

#echo "## Copyright (C) 2020 - 2021 ENCRYPTED SUPPORT LP <adrelanos@whonix.org>
## See the file COPYING for copying conditions.

## https://forums.whonix.org/t/speeding-up-apt-update-with-acquire-languages-none-and-contents-deb-defaultenabled-false-its-so-much-faster/8894/2
#Acquire::Languages none;
#Acquire::IndexTargets::deb::Contents-deb::DefaultEnabled false;" > /etc/apt/apt.conf.d/99translations

echo "## Use with care.
## Comment in only if you know what you are doing.
## See also:
## https://www.whonix.org/wiki/Dev/Permissions
%sudo   ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/user-passwordless


#ash -c "cat >> /etc/default/grub" << EOF
# disable ipv6
#GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1"
#GRUB_CMDLINE_LINUX="ipv6.disable=1"
#EOF

update-grub

timedatectl set-timezone Europe/Stockholm
echo 'Europe/Stockholm' /etc/timezone
ln -fs /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

cat>/etc/ssh/sshd_config<<__EOF
Port 22
Protocol 2
AuthorizedKeysFile  /etc/ssh/authorized_keys
PasswordAuthentication yes
ChallengeResponseAuthentication no
UsePAM no
X11Forwarding yes
PermitRootLogin yes
PermitEmptyPasswords yes
Subsystem sftp /usr/lib/openssh/sftp-server
KeepAlive yes
PrintMotd yes
__EOF

curl -O https://github.com/brra.keys
mv brra.keys /etc/ssh/authorized_keys
chmod 644 /etc/ssh/authorized_keys
systemctl daemon-reload
systemctl restart ssh

apt install cifs-utils
#mkdir /mnt/stuff /mnt/mov_tv
#echo "//192.168.1.10/stuff  /mnt/stuff  cifs  guest,rw,relatime,vers=3.0,cache=strict,uid=1000,noforceuid,gid=1000,noforcegid,addr=192.168.1.10,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=4194304,wsize=4194304,bsize=1048576,echo_interval=60,actimeo=1 0 0"  >> /etc/fstab
#echo "//192.168.1.10/movie_tv  /mnt/mov_tv  cifs  guest,rw,relatime,vers=3.0,cache=strict,uid=1000,noforceuid,gid=1000,noforcegid,addr=192.168.1.10,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=4194304,wsize=4194304,bsize=1048576,echo_interval=60,actimeo=1  0 0"  >> /etc/fstab
