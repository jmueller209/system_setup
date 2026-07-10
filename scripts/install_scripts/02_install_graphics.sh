#!/bin/bash

# 1. Setup and Source Utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

echo "=========================================="
echo " Setting up Hyprland & GUI Environment"
echo "=========================================="

# ---------------------------------------------------------
# HELPER FUNCTIONS
# ---------------------------------------------------------

setup_starship() {
    local STARSHIP_INIT='eval "$(starship init bash)"'
    
    # Check if the line already exists in the file
    if ! grep -Fxq "$STARSHIP_INIT" ~/.bashrc; then
        echo "" >> ~/.bashrc 
        echo "$STARSHIP_INIT" >> ~/.bashrc
        echo "  - Starship hook added to ~/.bashrc"
    else
        echo "  - Starship is already configured in ~/.bashrc"
    fi
}

install_nerdfont() {
    local FONT_NAME=${1:-"FiraCode"}
    local URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.zip"
    local FONT_DIR="$HOME/.local/share/fonts/${FONT_NAME}"
    local TMP_ZIP="/tmp/${FONT_NAME}.zip"

    if [ -d "$FONT_DIR" ]; then
        echo "  - ${FONT_NAME} Nerd Font is already installed."
        return 0
    fi

    echo "  - Downloading ${FONT_NAME}..."
    wget -q --show-progress "$URL" -O "$TMP_ZIP" || return 1
    
    mkdir -p "$FONT_DIR"
    unzip -q -o "$TMP_ZIP" -d "$FONT_DIR"
    rm "$TMP_ZIP"

    fc-cache -fv &> /dev/null
}

install_wallust() {
    # Teach THIS specific script where Cargo is right before we need it
    if [ -f "$HOME/.cargo/env" ]; then
        source "$HOME/.cargo/env"
    fi
    # Check if cargo is available (installed in 00_dev_tools)
    if ! command -v cargo &> /dev/null; then
        echo "  - ERROR: Cargo is not installed. Run dev tools script first."
        return 1
    fi

    # Check if wallust is already installed
    if command -v wallust &> /dev/null; then
        echo "  - Wallust is already installed."
        return 0
    fi

    # Run cargo install (DO NOT use sudo here)
    cargo install wallust
}

enable_display_manager() {
    # Only enable if it's not already enabled to prevent unnecessary systemctl output
    if ! systemctl is-enabled sddm.service &> /dev/null; then
        sudo systemctl enable sddm.service
    fi
    sudo systemctl set-default graphical.target
}

# ---------------------------------------------------------
# EXECUTION PHASE
# ---------------------------------------------------------

# 1. Add Copr Repositories
execute_step "Enabling Starship Repo" sudo dnf copr enable atim/starship -y
execute_step "Enabling Lionheartp Hyprland Repo" sudo dnf copr enable lionheartp/Hyprland -y

# 2. System Packages (Using --allowerasing to fix Tuned/PPD conflicts)
GUI_PACKAGES=(
    "hyprland"
    "sddm"
    "tuned"
    "kitty"
    "waybar"
    "hyprpolkitagent"
    "nautilus"
    "pavucontrol"
    "alsa-sof-firmware"
    "alsa-utils"
    "blueman"
    "NetworkManager-wifi"
    "iwl*"
    "nm-connection-editor"
    "gvfs"
    "gvfs-mtp"
    "wofi"
    "hyprlock"
    "hypridle"
    "hyprpaper"
    "fastfetch"
    "starship"
)

echo "Installing Hyprland & Core GUI Packages..."
for pkg in "${GUI_PACKAGES[@]}"; do
    execute_step "Installing $pkg" sudo dnf install --allowerasing -y "$pkg"
done

# 3. User Space Configurations
execute_step "Configuring Starship Prompt" setup_starship
execute_step "Installing FiraCode Nerd Font" install_nerdfont "FiraCode"
execute_step "Installing JetBrainsMono Nerd Font" install_nerdfont "JetBrainsMono"

# 4. Cargo / Rust Tools
execute_step "Installing Wallust (Colorscheme Gen)" install_wallust

# 5. Final System Hook
execute_step "Enabling SDDM & Graphical Login" enable_display_manager

echo "------------------------------------------"
echo "Graphics Script Finished."
