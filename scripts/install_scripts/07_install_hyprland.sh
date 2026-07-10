#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting Fedora Hyprland Installation Script...${NC}"


echo -e "${GREEN}==> Enabling solopasha/hyprland COPR repository...${NC}"
sudo dnf copr enable solopasha/hyprland -y

echo -e "${GREEN}==> Installing Hyprland, UI components, and core system tools...${NC}"
sudo dnf install -y hyprland sddm tuned tuned-ppd kitty waybar hyprpolkitagent \
    nautilus pavucontrol alsa-sof-firmware alsa-utils blueman NetworkManager-wifi \
    iwl* nm-connection-editor gvfs gvfs-mtp \
    wofi SwayNotificationCenter neovim hyprlock hypridle hyprpaper

cargo install wallust


echo -e "${GREEN}==> Enabling SDDM and setting graphical login...${NC}"
sudo systemctl enable sddm.service
sudo systemctl set-default graphical.target


