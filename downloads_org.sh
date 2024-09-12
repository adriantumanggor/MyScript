#!/bin/bash

# Set the path to the Downloads directory
DOWNLOADS_DIR=~/Downloads

# Define directories for each category
PDF_DIR="$DOWNLOADS_DIR/PDFs"
DOC_DIR="$DOWNLOADS_DIR/Docs"
IMG_DIR="$DOWNLOADS_DIR/Images"
MUSIC_DIR="$DOWNLOADS_DIR/Music"
VIDEO_DIR="$DOWNLOADS_DIR/Videos"
ARCHIVE_DIR="$DOWNLOADS_DIR/Archives"
OTHERS_DIR="$DOWNLOADS_DIR/Others"

# Create directories if they do not exist
mkdir -p "$PDF_DIR" "$DOC_DIR" "$IMG_DIR" "$MUSIC_DIR" "$VIDEO_DIR" "$ARCHIVE_DIR" "$OTHERS_DIR"

# Move files to their respective directories based on file extension
# PDFs
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.pdf" -exec mv {} "$PDF_DIR" \;

# Documents (.docx, .xlsx, .pptx, .txt)
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.docx" -exec mv {} "$DOC_DIR" \;
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.xlsx" -exec mv {} "$DOC_DIR" \;
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.pptx" -exec mv {} "$DOC_DIR" \;
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.txt" -exec mv {} "$DOC_DIR" \;

# Images (.jpg, .png, .gif)
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.jpg" -exec mv {} "$IMG_DIR" \;
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.jpeg" -exec mv {} "$IMG_DIR" \;
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.png" -exec mv {} "$IMG_DIR" \;
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.gif" -exec mv {} "$IMG_DIR" \;

# Music (.mp3, .wav)
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.mp3" -exec mv {} "$MUSIC_DIR" \;
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.wav" -exec mv {} "$MUSIC_DIR" \;

# Videos (.mp4, .mkv, .avi)
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.mp4" -exec mv {} "$VIDEO_DIR" \;
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.mkv" -exec mv {} "$VIDEO_DIR" \;
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.avi" -exec mv {} "$VIDEO_DIR" \;

# Archives (.zip, .tar.gz, .rar)
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.zip" -exec mv {} "$ARCHIVE_DIR" \;
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.tar.gz" -exec mv {} "$ARCHIVE_DIR" \;
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -iname "*.rar" -exec mv {} "$ARCHIVE_DIR" \;

# Move any remaining files to "Others"
find "$DOWNLOADS_DIR" -maxdepth 1 -type f -exec mv {} "$OTHERS_DIR" \;

echo "Downloads directory organized!"
