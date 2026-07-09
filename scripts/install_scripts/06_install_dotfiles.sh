#!/bin/bash

set -e

echo "--- 6. Installing Dotfiles (GNU Stow) ---"

SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOTFILES_DIR="$SETUP_ROOT/dotfiles"

echo "Found dotfiles directory at: $DOTFILES_DIR"

cd "$DOTFILES_DIR"

echo "Stowing files to $HOME..."
stow -t "$HOME" .

echo "--- Dotfiles successfully linked! ---"
