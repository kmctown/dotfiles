#!/bin/sh

echo "Installing fonts..."

# Installs fonts onto the system
brew tap homebrew/cask-fonts

fonts=(
  font-fira-code-nerd-font
  font-menlo-for-powerline
)

brew install --cask ${fonts[@]}
