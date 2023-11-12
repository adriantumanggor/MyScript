#!/bin/bash

# Setel pesan commit
COMMIT_MESSAGE="${1:-Pesan commit default}"

# Tambahkan semua perubahan ke staging area
git add .
git add --all

# Lakukan commit dengan pesan yang diberikan
git commit -m "$COMMIT_MESSAGE"

# Push perubahan ke GitHub
git push 

# Pesan berhasil
echo "Perubahan berhasil di-commit dan di-push ke GitHub."
