#!/bin/sh
#
# cmux
#
# Installs cmux (native macOS terminal for AI agent coding) and sets up config

# Install cmux via Homebrew cask
if ! command -v cmux &> /dev/null; then
    echo "  Installing cmux"
    brew tap manaflow-ai/cmux
    brew install --cask cmux
fi

# Set up CLI symlink
if [ ! -f /usr/local/bin/cmux ]; then
    echo "  Linking cmux CLI"
    sudo ln -sf "/Applications/cmux.app/Contents/Resources/bin/cmux" /usr/local/bin/cmux
fi

# Create config dirs
mkdir -p ~/.config/cmux

# Symlink settings.json
SETTINGS_TARGET="$HOME/.config/cmux/settings.json"
if [ ! -L "$SETTINGS_TARGET" ]; then
    ln -sf "$HOME/.dotfiles/cmux/settings.json" "$SETTINGS_TARGET"
    echo "  Linked settings.json"
fi

# Symlink global cmux.json (custom commands)
CMUX_JSON_TARGET="$HOME/.config/cmux/cmux.json"
if [ ! -L "$CMUX_JSON_TARGET" ]; then
    ln -sf "$HOME/.dotfiles/cmux/cmux.json" "$CMUX_JSON_TARGET"
    echo "  Linked cmux.json"
fi

exit 0
