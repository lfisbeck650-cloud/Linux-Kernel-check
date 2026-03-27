#!/bin/bash
# Universal installer for kernelcheck (Arch + Debian/Ubuntu/Lubuntu)
# Clones/updates the repo, makes the script executable, and adds it permanently to PATH

INSTALL_DIR="$HOME/kernelcheck"

# Detect shell config file
SHELL_CONFIG="$HOME/.bashrc"
if [ -n "$ZSH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

echo "Starting kernelcheck installer..."

# Function to install git
install_git() {
    if command -v pacman &>/dev/null; then
        echo "Installing Git on Arch..."
        sudo pacman -Sy --noconfirm git
    elif command -v apt &>/dev/null; then
        echo "Installing Git on Debian/Ubuntu/Lubuntu..."
        sudo apt update
        sudo apt install -y git
    else
        echo "Git not found and automatic installation failed. Please install Git manually."
        exit 1
    fi
}

# Check if git is installed
if ! command -v git &>/dev/null; then
    install_git
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
    echo "Adding kernelcheck to PATH in $SHELL_CONFIG..."
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
