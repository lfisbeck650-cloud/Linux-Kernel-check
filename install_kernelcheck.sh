#!/bin/bash
# Full installer for kernelcheck
# This installer clones/updates the repo, makes the script executable,
# and automatically adds it permanently to your PATH.

INSTALL_DIR="$HOME/kernelcheck"
SHELL_CONFIG="$HOME/.bashrc"

# Detect shell for Zsh users
if [ -n "$ZSH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

echo "Starting kernelcheck installer..."

# Check if Git is installed
if ! command -v git &>/dev/null; then
    echo "Git is not installed. Installing Git now..."
    sudo pacman -S --noconfirm git
fi

# Clone or update the repository
if [ -d "$INSTALL_DIR" ]; then
    echo "Updating existing kernelcheck installation..."
    cd "$INSTALL_DIR" && git pull
else
    echo "Cloning kernelcheck repository..."
    git clone https://github.com/lfisbeck650-cloud/Linux-Kernel-check.git "$INSTALL_DIR"
fi

# Make the script executable
chmod +x "$INSTALL_DIR/kernelcheck"

# Add to PATH permanently if not already in shell config
if ! grep -Fxq "export PATH=\"$INSTALL_DIR:\$PATH\"" "$SHELL_CONFIG"; then
    echo "Adding kernelcheck to your PATH in $SHELL_CONFIG..."
    echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$SHELL_CONFIG"
fi

# Temporarily add to PATH for this session
export PATH="$INSTALL_DIR:$PATH"

# Test kernelcheck
if command -v kernelcheck &>/dev/null; then
    echo ""
    echo "✅ Installation complete!"
    echo "You can now run 'kernelcheck' from any terminal session."
    kernelcheck
else
    echo ""
    echo "⚠️ Something went wrong. Please check the installation."
fi
