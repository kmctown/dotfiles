#!/bin/bash	

if test $(which brew)	
then	
  echo "Installing vscode..."	

  brew cask install visual-studio-code	

  echo "Installing vscode extensions..."	

  # Run `code --list-extensions` to check current extensions	
  declare -a CODE_EXTENSIONS=(	
    TsumiNa.Seti-theme	
    donjayamanne.githistory	
    esbenp.prettier-vscode	
    GitHub.vscode-pull-request-github	
    jpoissonnier.vscode-styled-components	
    ms-python.python	
    ms-vscode.atom-keybindings	
    qinjia.seti-icons	
    sensourceinc.vscode-sql-beautify	
    vscodevim.vim	
  )	

  for ext in ${CODE_EXTENSIONS[@]}; do	
     code --install-extension $ext	
  done	
fi	

exit 0
