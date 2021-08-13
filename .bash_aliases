#!/bin/bash
#
# Provides:             .bash-aliases
# Short-Description:    global aliases
# Description:          global aliases

# global
alias l='ls -CF --color=auto'
alias la='ls -A --color=auto'
alias ls='ls --color=auto'
alias ll='ls -alF --color=auto'
alias df='df -h'
alias st='sublime-text'
alias watch='watch --color'
alias nano='nano -wY conf'
alias grep='grep --color'
alias etrash='sudo find / -not \( -regex "\(/proc\|/sys\|/run/user\)" -prune \) -not -type p -name .Trash* -exec echo "{}" \; -exec sudo rm -fR "{}" \;'
alias ced='clean-keep && etrash'
alias histg='history|grep'
alias histgs="history|sed 's|^ \+[0-9]\+ \+||'|grep"
alias du0="__du 0"
alias du1="__du 1"
alias du2="__du 2"
alias dfs="df -x tmpfs -x devtmpfs | grep -v /dev/ploop"
