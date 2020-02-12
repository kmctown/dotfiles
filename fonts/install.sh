#!/bin/sh

echo "Installing fonts..."

# Installs fonts onto the system
brew tap homebrew/cask-fonts

fonts=(
  font-firacode-nerd-font
  font-menlo-for-powerline
)

brew cask install ${fonts[@]}
