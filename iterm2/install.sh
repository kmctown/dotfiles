#!/bin/sh

ITERM2COLORSCHEMES=${PROJECTS:-$HOME/Code}/iTerm2-Color-Schemes

if [ ! -d $ITERM2COLORSCHEMES ]; then
  echo 'Cloning iTerm2 color schemes...'

  mkdir -p "$(dirname $ITERM2COLORSCHEMES)"
  git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git $ITERM2COLORSCHEMES
fi
