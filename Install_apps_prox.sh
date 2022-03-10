#!/bin/bash

apt update && apt full-upgrade

apt install -y  --no-install-recommends \
apt-transport-https \
ca-certificates \
curl \
dirmngr \
gnupg-agent \
software-properties-common \
bash-completion \
command-not-found \
dialog \
net-tools \
git \
gnupg2 \
locales \
autofs \
lsb-release  \
adduser \
tmux \
tmux-plugin-manager \
gnupg \
hostname  \
python3  \
python3-dev  \
python3-pip

update-alternatives --config python

apt -y install python python3-virtualenv
pip install pip-upgrader
pip install --upgrade pip

