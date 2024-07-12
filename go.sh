#!/bin/bash

# Memeriksa apakah argumen diberikan
if [ $# -eq 0 ]; then
    echo "Usage: $0 <nama_file1> <nama_file2> ..."
    exit 1
fi

# Loop melalui semua argumen
for file_name in "$@"
do
    # Membuat file menggunakan perintah touch
    touch $file_name

    # Membuka file menggunakan Visual Studio Code
    code $file_name
done
``
