#!/bin/bash

# Ensure script is run with sudo
if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root (sudo ./install.sh)"
  exit
fi

INSTALL_DIR="/opt/oss-cad-suite"
ARCH="linux-x64"

echo "--- Setting up FPGA Toolchain ---"

# 1. Download and Install to /opt
echo "Fetching latest release..."
LATEST_URL=$(curl -s https://api.github.com/repos/YosysHQ/oss-cad-suite-build/releases/latest \
| grep "browser_download_url.*$ARCH" \
| cut -d '"' -f 4)

wget -O suite.tgz "$LATEST_URL"
rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
tar -xvf suite.tgz -C "$INSTALL_DIR" --strip-components=1
rm suite.tgz

# 2. Make tools globally available
echo "Updating system PATH..."
echo 'export PATH=/opt/oss-cad-suite/bin:$PATH' > /etc/profile.d/oss-cad.sh

# 3. Handle Udev Rules
if [ -f "99-gatemate.rules" ]; then
    echo "Installing Udev rules..."
    cp 99-gatemate.rules /etc/udev/rules.d/
    udevadm control --reload-rules
    udevadm trigger
else
    echo "Warning: 99-gatemate.rules not found. Skipping USB permissions."
fi

echo "--- Setup Complete! ---"
echo "Please log out and log back in for changes to take effect."
