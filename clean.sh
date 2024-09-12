#!/bin/bash

# Directory to move files into
DEST_DIR=~/Documents

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# File extensions to clean up (you can add or remove extensions as needed)
EXTENSIONS=("*.pdf" "*.docx" "*.xlsx" "*.pptx" "*.txt" "*.jpg" "*.png")

# Loop over extensions and move matching files to the destination directory
for ext in "${EXTENSIONS[@]}"; do
    find ~ -maxdepth 1 -type f -name "$ext" -exec mv {} "$DEST_DIR" \;
done

echo "Files moved to $DEST_DIR"
