#!/bin/sh

mkdir -p ~/.config/ghostty

if [ ! -L ~/.config/ghostty/config ]; then
  ln -sf "$HOME/.dotfiles/ghostty/config" ~/.config/ghostty/config
  echo "  Linked ghostty config"
fi
