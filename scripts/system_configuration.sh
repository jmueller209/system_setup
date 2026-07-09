#!/bin/bash

export DNF_ASSUME_YES=1

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

TARGET_DIRS=(
    "$SCRIPT_DIR/install_scripts"
    "$SCRIPT_DIR/setup_scripts"
)

echo "=========================================="
echo "Starting System Orchestration"
echo "=========================================="

for dir in "${TARGET_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo ">>> Entering directory: $dir"
        
        for script in "$dir"/*.sh; do
            [ -e "$script" ] || continue
            
            echo "    Executing: $script"
            bash "$script"
            echo "    [SUCCESS] $script"
        done
    else
        echo "!!! Warning: Directory '$dir' not found. Skipping."
    fi
done

echo "=========================================="
echo "System configuration complete!"
echo "=========================================="
