#!/bin/bash

# Configuration
EMAIL="jonas.mueller.wpk@gmail.com"
KEY_FILE="$HOME/.ssh/id_ed25519"

echo "--- Setting up SSH Keys ---"

# 1. Create the key if it doesn't exist
if [ ! -f "$KEY_FILE" ]; then
    echo "Generating new Ed25519 SSH key..."
    ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_FILE" -N ""
else
    echo "SSH key already exists, skipping generation."
fi

# 2. Add to SSH Agent
eval "$(ssh-agent -s)" > /dev/null
ssh-add "$KEY_FILE"

echo "----------------------------------------------------"
echo "SSH Key Setup Complete!"
echo "Your public key is:"
echo "----------------------------------------------------"
cat "${KEY_FILE}.pub"
echo "----------------------------------------------------"
echo "1. Copy the block above to your GitHub settings."
echo "2. To copy this to your Raspberry Pi, run: ssh-copy-id user@<rpi-ip-address>"
echo "----------------------------------------------------"

# Wait for user input
read -p "Press [Enter] key to finish and close this window..."
