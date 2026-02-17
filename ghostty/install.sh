#!/bin/sh

mkdir -p "$HOME/.config/ghostty"
ln -sf "$HOME/.dotfiles/ghostty/config" "$HOME/.config/ghostty/config"
echo "  Linked ghostty config"
