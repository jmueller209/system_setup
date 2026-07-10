#!/bin/bash

# 1. Setup and Source Utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

echo "=========================================="
echo " Setting up System Dotfiles"
echo "=========================================="

# ---------------------------------------------------------
# HELPER FUNCTIONS
# ---------------------------------------------------------

link_dotfiles() {
    # Resolve the root directory of your setup repository
    # (Adjusts the path based on where this script lives)
    local SETUP_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
    local DOTFILES_DIR="$SETUP_ROOT/dotfiles"

    # Check if the directory actually exists before trying to link
    if [ ! -d "$DOTFILES_DIR" ]; then
        echo "  - ERROR: Dotfiles directory not found at: $DOTFILES_DIR"
        return 1
    fi

    # Navigate to the dotfiles directory (safe because it's trapped in this function)
    cd "$DOTFILES_DIR" || return 1

    # Run GNU Stow to symlink everything into the home directory.
    # We use --restow (-R) to ensure it cleans up dead links and reapplies active ones.
    stow -R -t "$HOME" .
}

# ---------------------------------------------------------
# EXECUTION PHASE
# ---------------------------------------------------------

execute_step "Symlinking Dotfiles via GNU Stow" link_dotfiles

echo "------------------------------------------"
echo "Dotfiles Script Finished."
