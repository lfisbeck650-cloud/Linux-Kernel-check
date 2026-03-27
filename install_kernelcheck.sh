#!/bin/bash
# Super-kompletter Installer für kernelcheck

INSTALL_DIR="$HOME/kernelcheck"

echo "Starting kernelcheck installer..."

# Prüfen, ob Git installiert ist
if ! command -v git &>/dev/null; then
    echo "Git is not installed. Installing Git now..."
    sudo pacman -S --noconfirm git
fi

# Repo klonen oder updaten
if [ -d "$INSTALL_DIR" ]; then
    echo "Updating existing kernelcheck installation..."
    cd "$INSTALL_DIR"
    git pull
else
    echo "Cloning kernelcheck repository..."
    git clone https://github.com/lfisbeck650-cloud/Linux-Kernel-check.git "$INSTALL_DIR"
fi

# Skript ausführbar machen
chmod +x "$INSTALL_DIR/kernelcheck"

# PATH temporär hinzufügen
export PATH="$INSTALL_DIR:$PATH"

# Testen, ob kernelcheck funktioniert
if command -v kernelcheck &>/dev/null; then
    echo ""
    echo "✅ Installation complete!"
    echo "You can now run 'kernelcheck' directly:"
    kernelcheck
else
    echo ""
    echo "⚠️ Something went wrong. You may need to add the following to your ~/.bashrc or ~/.zshrc manually:"
    echo "export PATH=\"$INSTALL_DIR:\$PATH\""
fi

echo ""
echo "To make 'kernelcheck' available in all future sessions, add this line to ~/.bashrc or ~/.zshrc:"
echo "export PATH=\"$INSTALL_DIR:\$PATH\""
