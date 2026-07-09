#!/bin/bash
set -e

# Configuration
INSTALL_DIR="/usr/local/riscv-none-elf"
TEMP_DIR="/tmp/riscv_install"

# 1. Fetch the latest release tag from GitHub API
echo "Querying GitHub for the latest toolchain version..."
LATEST_TAG=$(curl -s https://api.github.com/repos/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/latest | grep tag_name | cut -d '"' -f 4)
# Remove the 'v' from the tag name (e.g., v15.2.0-1.1 -> 15.2.0-1.1)
VERSION=${LATEST_TAG#v}

# 2. Construct the URL dynamically
SRC_URL="https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/download/$LATEST_TAG/xpack-riscv-none-elf-gcc-$VERSION-linux-x64.tar.gz"

echo "Detected latest version: $VERSION"
echo "Downloading from $SRC_URL..."

mkdir -p "$TEMP_DIR"
wget -O "$TEMP_DIR/riscv-gcc.tar.gz" "$SRC_URL"

# 3. Clean install to standard directory
echo "Installing to $INSTALL_DIR (requires sudo)..."
sudo rm -rf "$INSTALL_DIR"
sudo mkdir -p "$INSTALL_DIR"
sudo tar -xvf "$TEMP_DIR/riscv-gcc.tar.gz" -C "$INSTALL_DIR" --strip-components=1

# 4. Cleanup
rm -rf "$TEMP_DIR"

# 5. Add to PATH
if ! grep -q "$INSTALL_DIR/bin" "$HOME/.bashrc"; then
    echo "export PATH=\$PATH:$INSTALL_DIR/bin" >> "$HOME/.bashrc"
    echo "Added to ~/.bashrc."
fi

echo "Installation complete!"
echo "Please run: source ~/.bashrc"
