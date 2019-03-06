export ZSH=~/.oh-my-zsh

ZSH_THEME="agnoster"
DEFAULT_USER=$(whoami)

plugins=(docker git yarn z)

source $ZSH/oh-my-zsh.sh
