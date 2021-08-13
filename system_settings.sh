#!/bin/bash

export DEBIAN_FRONTEND=dialog
export TERM=xterm-color


# turn off translations, speed up apt update
mkdir -p /etc/apt/apt.conf.d
echo "## Copyright (C) 2020 - 2021 ENCRYPTED SUPPORT LP <adrelanos@whonix.org>
## See the file COPYING for copying conditions.

## https://forums.whonix.org/t/speeding-up-apt-update-with-acquire-languages-none-and-contents-deb-defaultenabled-false-its-so-much-faster/8894/2
Acquire::Languages none;
Acquire::IndexTargets::deb::Contents-deb::DefaultEnabled false;" > /etc/apt/apt.conf.d/99translations

echo "## Use with care.
## Comment in only if you know what you are doing.
## See also:
## https://www.whonix.org/wiki/Dev/Permissions
%sudo   ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/user-passwordless

sudo bash -c "cat >> /etc/sysctl.conf" << EOF
net.ipv4.tcp_slow_start_after_idle=0
net.core.rmem_max=16777216
fs.inotify.max_user_watches=1048576
kernel.softlockup_all_cpu_backtrace=1
kernel.softlockup_panic=1
fs.file-max=2097152 
fs.nr_open=2097152
fs.may_detach_mounts=1
fs.inotify.max_user_instances=8192
fs.inotify.max_queued_events=16384
vm.max_map_count=262144
net.core.netdev_max_backlog=16384
net.ipv4.tcp_wmem=4096 12582912 16777216
net.core.wmem_max=16777216
net.core.somaxconn=32768
net.ipv4.ip_forward=1
net.ipv4.tcp_timestamps=0
net.ipv4.tcp_max_syn_backlog=8096
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-ip6tables=1
net.bridge.bridge-nf-call-arptables=1
net.ipv4.tcp_rmem=4096 12582912 16777216
vm.swappiness=0
kernel.sysrq=1
net.ipv4.neigh.default.gc_stale_time=120
net.ipv4.conf.all.rp_filter=0
net.ipv4.conf.default.rp_filter=0
net.ipv4.conf.default.arp_announce=2
net.ipv4.conf.lo.arp_announce=2
net.ipv4.conf.all.arp_announce=2
net.ipv4.tcp_max_tw_buckets=5000
net.ipv4.tcp_syncookies=1
net.ipv4.tcp_synack_retries=2
net.ipv6.conf.lo.disable_ipv6=1
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1
net.ipv4.ip_local_port_range=1024 65535
net.ipv4.tcp_keepalive_time=600
net.ipv4.tcp_keepalive_probes=10
net.ipv4.tcp_keepalive_intvl=30
net.ipv4.tcp_orphan_retries=3
net.nf_conntrack_max=25000000
net.netfilter.nf_conntrack_max=25000000
net.netfilter.nf_conntrack_tcp_timeout_established=180
net.netfilter.nf_conntrack_tcp_timeout_time_wait=120
net.netfilter.nf_conntrack_tcp_timeout_close_wait=60
net.netfilter.nf_conntrack_tcp_timeout_fin_wait=12
EOF

sudo sysctl -p

sudo bash -c "cat >> /etc/default/grub" << EOF
# disable ipv6
GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1"
GRUB_CMDLINE_LINUX="ipv6.disable=1"
EOF

sudo update-grub

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
mkdir /mnt/stuff /mnt/mov_tv
echo "//192.168.1.10/stuff  /mnt/stuff  cifs  guest,rw,relatime,vers=3.0,cache=strict,uid=1000,noforceuid,gid=1000,noforcegid,addr=192.168.1.10,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=4194304,wsize=4194304,bsize=1048576,echo_interval=60,actimeo=1 0 0"  >> /etc/fstab
echo "//192.168.1.10/movie_tv  /mnt/mov_tv  cifs  guest,rw,relatime,vers=3.0,cache=strict,uid=1000,noforceuid,gid=1000,noforcegid,addr=192.168.1.10,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=4194304,wsize=4194304,bsize=1048576,echo_interval=60,actimeo=1  0 0"  >> /etc/fstab