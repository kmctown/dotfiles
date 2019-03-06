export ZSH=~/.oh-my-zsh

if [ ! -d $ZSH ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
