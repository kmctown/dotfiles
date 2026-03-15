#!/bin/sh
#
# Zellij
#
# Installs zellij and sets up layouts

# Install zellij if not present
if ! command -v zellij &> /dev/null; then
    echo "  Installing zellij"
    brew install zellij
fi

# Install lazygit if not present (used in layouts)
if ! command -v lazygit &> /dev/null; then
    echo "  Installing lazygit"
    brew install lazygit
fi

# Create config dir if needed
mkdir -p ~/.config/zellij/layouts

# Symlink config
CONFIG_TARGET="$HOME/.config/zellij/config.kdl"
if [ ! -L "$CONFIG_TARGET" ]; then
    ln -sf "$HOME/.dotfiles/zellij/config.kdl" "$CONFIG_TARGET"
    echo "  Linked config.kdl"
fi

# Symlink layouts
DOTFILES_ZELLIJ="$HOME/.dotfiles/zellij/layouts"
for layout in "$DOTFILES_ZELLIJ"/*.kdl; do
    filename=$(basename "$layout")
    target="$HOME/.config/zellij/layouts/$filename"
    if [ ! -L "$target" ]; then
        ln -sf "$layout" "$target"
        echo "  Linked $filename"
    fi
done

exit 0
