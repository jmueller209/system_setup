#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting Fedora Hyprland Installation Script...${NC}"

echo -e "${GREEN}==> Enabling atim/starship COPR repository...${NC}"
sudo dnf copr enable atim/starship -y
echo -e "${GREEN}==> Installing Starship ...${NC}"
sudo dnf install -y starship
STARSHIP_INIT='eval "$(starship init bash)"'

if ! grep -Fxq "$STARSHIP_INIT" ~/.bashrc; then
    echo "" >> ~/.bashrc 
    echo "$STARSHIP_INIT" >> ~/.bashrc
    echo "Starship added to .bashrc"
else
    echo "Starship is already in .bashrc"
fi

echo -e "${GREEN}==> Enabling solopasha/hyprland COPR repository...${NC}"
sudo dnf copr enable solopasha/hyprland -y

echo -e "${GREEN}==> Installing Hyprland, UI components, and core system tools...${NC}"
sudo dnf install -y hyprland sddm tuned tuned-ppd kitty waybar hyprpolkitagent \
    nautilus pavucontrol alsa-sof-firmware alsa-utils blueman NetworkManager-wifi \
    iwl* nm-connection-editor gvfs gvfs-mtp \
    wofi hyprlock hypridle hyprpaper neofetch

echo -e "${GREEN}==> Installing additional tools and utilities...${NC}"
cargo install wallust


echo -e "${GREEN}==> Enabling SDDM and setting graphical login...${NC}"
sudo systemctl enable sddm.service
sudo systemctl set-default graphical.target


