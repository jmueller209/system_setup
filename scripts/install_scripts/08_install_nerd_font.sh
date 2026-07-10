#!/bin/bash

FONT_NAME=${1:-"FiraCode"}
URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.zip"
FONT_DIR="$HOME/.local/share/fonts/${FONT_NAME}"

echo "Starting installation for ${FONT_NAME} Nerd Font..."

for cmd in wget unzip fc-cache; do
  if ! command -v $cmd &> /dev/null; then
    echo "Error: '$cmd' is required but not installed. Please install it first."
    exit 1
  fi
done

echo "Downloading ${FONT_NAME}.zip..."
wget -q --show-progress "$URL" -O "${FONT_NAME}.zip"

if [ $? -ne 0 ]; then
    echo "Error: Failed to download the font. Check if the font name is spelled correctly."
    rm -f "${FONT_NAME}.zip"
    exit 1
fi

echo "Extracting to ${FONT_DIR}..."
mkdir -p "$FONT_DIR"
unzip -q -o "${FONT_NAME}.zip" -d "$FONT_DIR"

echo "Cleaning up..."
rm "${FONT_NAME}.zip"

echo "Updating system font cache..."
fc-cache -fv &> /dev/null

echo "Success! ${FONT_NAME} Nerd Font is now installed and ready to use."
