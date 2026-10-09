#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# --- CONFIGURATION ---
DOTFILES_DIR="$HOME/dotfiles"
BIN_DIR="$HOME/.local/bin"
FONT_DIR="$HOME/.local/share/fonts"
FONT_NAME="JetBrainsMono"

echo "=========================================="
echo " Starting Portable Dotfiles Setup Script "
echo "=========================================="

# 1. Ensure required directories exist
mkdir -p "$BIN_DIR"
mkdir -p "$FONT_DIR"
mkdir -p "$HOME/.config"

# Ensure ~/.local/bin is in PATH for the current script execution
export PATH="$BIN_DIR:$PATH"

# -----------------------------------------------------------------------------
# STEP 1: INSTALL NEOVIM (NO-SUDO APPIMAGE FALLBACK)
# -----------------------------------------------------------------------------
echo ""
echo "==> Checking Neovim installation..."

if command -v nvim >/dev/null 2>&1; then
    echo "    Neovim is already installed: $(nvim --version | head -n 1)"
else
    echo "    Neovim not found. Downloading latest standalone AppImage to $BIN_DIR..."
    TEMP_NVIM=$(mktemp -d)
    curl -fLo "${TEMP_NVIM}/nvim.appimage" "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage"
    chmod +x "${TEMP_NVIM}/nvim.appimage"
    mv "${TEMP_NVIM}/nvim.appimage" "$BIN_DIR/nvim"
    rm -rf "$TEMP_NVIM"
    echo "    Neovim successfully installed to $BIN_DIR/nvim"
fi

# -----------------------------------------------------------------------------
# STEP 2: INSTALL NERD FONT (JETBRAINSMONO)
# -----------------------------------------------------------------------------
echo ""
echo "==> Checking $FONT_NAME Nerd Font..."

if command -v fc-list >/dev/null 2>&1 && fc-list : family | grep -iq "$FONT_NAME Nerd Font"; then
    echo "    $FONT_NAME Nerd Font is already installed."
else
    echo "    Installing $FONT_NAME Nerd Font into $FONT_DIR..."
    TEMP_FONT=$(mktemp -d)
    DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.tar.xz"

    curl -fLo "${TEMP_FONT}/${FONT_NAME}.tar.xz" "$DOWNLOAD_URL"
    tar -xJf "${TEMP_FONT}/${FONT_NAME}.tar.xz" -C "$FONT_DIR"
    rm -rf "$TEMP_FONT"

    if command -v fc-cache >/dev/null 2>&1; then
        echo "    Refreshing font cache..."
        fc-cache -f "$FONT_DIR"
    fi
    echo "    $FONT_NAME Nerd Font successfully installed!"
fi

# -----------------------------------------------------------------------------
# STEP 3: SYMLINK DOTFILES (GNU STOW WITH MANUAL FALLBACK)
# -----------------------------------------------------------------------------
echo ""
echo "==> Symlinking configuration files..."

if command -v stow >/dev/null 2>&1; then
    echo "    GNU Stow found. Applying stowed packages..."
    cd "$DOTFILES_DIR"
    stow -R nvim kitty tmux
    echo "    Stowed: nvim, kitty, tmux"
else
    echo "    GNU Stow not found. Falling back to manual symlinking (ln -snf)..."

    # Neovim
    if [ -d "$DOTFILES_DIR/nvim/.config/nvim" ]; then
        ln -snf "$DOTFILES_DIR/nvim/.config/nvim" "$HOME/.config/nvim"
        echo "    Linked ~/.config/nvim"
    fi

    # Kitty
    if [ -d "$DOTFILES_DIR/kitty/.config/kitty" ]; then
        ln -snf "$DOTFILES_DIR/kitty/.config/kitty" "$HOME/.config/kitty"
        echo "    Linked ~/.config/kitty"
    fi

    # Tmux
    if [ -f "$DOTFILES_DIR/tmux/.tmux.conf" ]; then
        ln -snf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
        echo "    Linked ~/.tmux.conf"
    fi
fi

# -----------------------------------------------------------------------------
# STEP 4: SHELL ENVIRONMENT PATH CHECK
# -----------------------------------------------------------------------------
echo ""
echo "=========================================="
echo " Setup Completed Successfully! "
echo "=========================================="
echo ""
echo "NOTE: Make sure $BIN_DIR is in your shell PATH."
echo "If needed, add the following line to your ~/.zshrc or ~/.bashrc:"
echo ""
echo '  export PATH="$HOME/.local/bin:$PATH"'
echo ""
