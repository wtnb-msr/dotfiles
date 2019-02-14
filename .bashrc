
alias ls='ls -G' 
alias ll='ls -l'

alias less='less --tabs=4'
export LESSCHARSET=utf-8

PS1="\u@\h:\w\$ "

# history 
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export HISTIGNORE=ll:history

