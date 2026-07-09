#!/bin/bash

INSTALLER_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
INSTALLER_NAME="Miniconda3-latest-Linux-x86_64.sh"
INSTALL_DIR="$HOME/miniconda3"

set -e

echo "--- Preparing to install Miniconda ---"

echo "Downloading Miniconda installer..."
if [ -f "$INSTALLER_NAME" ]; then
    echo "Installer already exists locally, skipping download."
else
    wget "$INSTALLER_URL" -O "$INSTALLER_NAME"
fi

if [ -d "$INSTALL_DIR" ]; then
    echo "Existing installation found in $INSTALL_DIR. Removing..."
    rm -rf "$INSTALL_DIR"
fi

echo "Running installer..."
bash "$INSTALLER_NAME" -b -p "$INSTALL_DIR"

echo "Initializing Conda..."
"$INSTALL_DIR/bin/conda" init bash

echo "Disabling base environment auto-activation..."
"$INSTALL_DIR/bin/conda" config --set auto_activate_base false

echo "Cleaning up installer file..."
rm "$INSTALLER_NAME"

echo "--- Setup Complete! ---"
echo "To activate conda in your current terminal session, run:"
echo "source ~/.bashrc"
