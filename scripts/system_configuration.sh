#!/bin/bash

export DNF_ASSUME_YES=1

# Exit immediately if any command in a sub-script fails
set -e

# Define the folders to process, in the order you want them executed
TARGET_DIRS=("install_scripts" "setup_scripts")

echo "=========================================="
echo "Starting System Orchestration"
echo "=========================================="

for dir in "${TARGET_DIRS[@]}"; do
    # Check if the directory exists before trying to enter it
    if [ -d "$dir" ]; then
        echo ">>> Entering directory: $dir"
        
        # Loop through all files ending in .sh inside the current directory
        # The glob expansion ensures we only pick up .sh files
        for script in "$dir"/*.sh; do
            # Check if any .sh files were actually found
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
