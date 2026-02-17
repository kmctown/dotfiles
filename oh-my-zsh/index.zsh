export ZSH=~/.oh-my-zsh

ZSH_THEME="agnoster"
DEFAULT_USER=$(whoami)

plugins=(docker git yarn z)

[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
