#!/bin/sh

echo "Installing fonts..."

fonts=(
  font-fira-code-nerd-font
  font-menlo-for-powerline
)

brew install --cask ${fonts[@]}
