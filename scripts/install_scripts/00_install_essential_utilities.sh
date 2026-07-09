#!/bin/bash

set -e
echo "Starting Fedora Developer Environment Setup..."

echo "Installing core development groups..."
sudo dnf group install -y development-tools

echo "Installing essential utilities..."
sudo dnf install -y \
    curl \
    wget \
    git \
    vim \
    neovim \
    htop \
    cmake \
    podman \
    distrobox \
    gdb \
    codium \
    zathura \
    zathura-pdf-mupdf \
    texlive-scheme-medium \
    npm \
    stow

sudo npm install -g tree-sitter-cli
