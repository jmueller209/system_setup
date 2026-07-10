#!/bin/bash

# 1. Setup and Source Utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

echo "=========================================="
echo " Setting up Fedora Developer Environment"
echo "=========================================="

# ---------------------------------------------------------
# HELPER FUNCTIONS (The "Check if already installed" logic)
# ---------------------------------------------------------

install_vscodium_repo() {
    # Check if the repo file already exists
    if [ -f "/etc/yum.repos.d/vscodium.repo" ]; then 
        echo "  - VSCodium repo already configured."
        return 0 
    fi
    sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee /etc/yum.repos.d/vscodium.repo > /dev/null
}

install_oss_cad() {
    local INSTALL_DIR="/opt/oss-cad-suite"
    
    if [ -d "$INSTALL_DIR" ]; then
        echo "  - OSS-CAD Suite is already installed in $INSTALL_DIR."
        return 0
    fi

    local ARCH="linux-x64"
    local URL=$(curl -s https://api.github.com/repos/YosysHQ/oss-cad-suite-build/releases/latest | grep "browser_download_url.*$ARCH" | cut -d '"' -f 4)
    
    # Download to /tmp to keep things clean
    wget -q --show-progress -O /tmp/suite.tgz "$URL"
    
    # Needs sudo because it installs to /opt
    sudo mkdir -p "$INSTALL_DIR"
    sudo tar -xzf /tmp/suite.tgz -C "$INSTALL_DIR" --strip-components=1
    echo 'export PATH=/opt/oss-cad-suite/bin:$PATH' | sudo tee /etc/profile.d/oss-cad.sh > /dev/null
    rm /tmp/suite.tgz
    
    source /etc/profile.d/oss-cad.sh
    # Handle Udev rules if the file exists next to this script
    if [ -f "$SCRIPT_DIR/99-gatemate.rules" ]; then
        sudo cp "$SCRIPT_DIR/99-gatemate.rules" /etc/udev/rules.d/
        sudo udevadm control --reload-rules
        sudo udevadm trigger
    fi
}

install_miniconda() {
    local INSTALL_DIR="$HOME/miniconda3"
    
    if [ -d "$INSTALL_DIR" ] || command -v conda &> /dev/null; then
        echo "  - Miniconda already installed."
        return 0
    fi

    wget -q --show-progress "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" -O /tmp/miniconda.sh
    # Run silently (-b) and specify path (-p)
    bash /tmp/miniconda.sh -b -p "$INSTALL_DIR"
    
    # Initialize without opening a new shell
    "$INSTALL_DIR/bin/conda" init bash > /dev/null
    "$INSTALL_DIR/bin/conda" config --set auto_activate_base false
    rm /tmp/miniconda.sh
}

install_rust() {
    if [ -d "$HOME/.cargo" ] || command -v rustup &> /dev/null; then
        echo "  - Rust is already installed."
        return 0
    fi
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
}

install_tree_sitter() {
    if command -v tree-sitter &> /dev/null; then
        echo "  - Tree-sitter already installed."
        return 0
    fi
    sudo npm install -g tree-sitter-cli
}


# ---------------------------------------------------------
# EXECUTION PHASE (Using your utils.sh wrapper)
# ---------------------------------------------------------

# 1. System Repositories
execute_step "Adding VSCodium Repository" install_vscodium_repo

# 2. DNF Packages (DNF handles "already installed" natively)
execute_step "Installing DNF Development Groups" sudo dnf install -y @development-tools
execute_step "Installing DNF Utilities & Tools" sudo dnf install -y \
    curl wget git vim neovim htop cmake podman distrobox gdb \
    zathura zathura-pdf-mupdf texlive-scheme-medium npm stow codium

# 3. Global NPM Packages
execute_step "Installing Tree-Sitter CLI" install_tree_sitter

# 4. User-Space & Custom Toolchains
execute_step "Installing OSS-CAD Suite" install_oss_cad
execute_step "Installing Miniconda" install_miniconda
execute_step "Installing Rust Toolchain" install_rust

echo "------------------------------------------"
echo "Dev Tools Script Finished."
