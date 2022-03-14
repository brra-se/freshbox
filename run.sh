#!/usr/bin/env bash

cp .vimrc /root/.vimrc
cp .bash_aliases /root/.bash_aliases
cp .bashrc-root /root/.bashrc 
cp .tmux.conf /root/.tmux.conf 
cp .vimrc /root/.vimrc 
cp nanorc /etc/nanorc
cp .bashrc ~/.bashrc 
cp .vimrc ~/.vimrc 
cp .bash_aliases ~/.bash_aliases
cp .tmux.conf ~/.tmux.conf 
cp .vimrc ~/.vimrc 
#chown brra:brra -R /ubuntu/brra/

sh system_settings.se 
#sh Install_apps.sh
#sh Install_apps_prox.sh
#sh docker_manual.sh
#sh get_tailscale.sh
