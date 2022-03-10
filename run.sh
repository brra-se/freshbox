#!/usr/bin/env bash

cp .vimrc /root/.vimrc
cp .bash_aliases /root/.bash_aliases
cp .bashrc-root /root/.bashrc 
cp .tmux.conf /root/.tmux.conf 
cp .vimrc /root/.vimrc 
cp nanorc /etc/nanorc
cp .bashrc /home/brra/.bashrc 
cp .vimrc /home/brra/.vimrc 
cp .bash_aliases /home/brra/.bash_aliases
cp .tmux.conf /home/brra/.tmux.conf 
cp .vimrc /home/brra/.vimrc 
chown brra:brra -R /home/brra/

sh system_settings.se 
#sh Install_apps.sh
sh Install_apps_prox.sh
sh docker_manual.sh
#sh get_tailscale.sh
