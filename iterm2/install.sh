#!/bin/sh

ITERM2COLORSCHEMES=$PROJECTS/iTerm2-Color-Schemes

if [ ! -d $ITERM2COLORSCHEMES ]; then
  echo 'Cloning iTerm2 color schemes...'
  
  git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git $ITERM2COLORSCHEMES
fi

