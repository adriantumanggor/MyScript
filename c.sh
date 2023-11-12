#!/bin/bash

# Cek apakah argumen file C telah diberikan
if [ $# -eq 0 ]; then
    echo "Usage: $0 <nama_file.c>"
    exit 1
fi

# Ambil nama file C dari argumen pertama
file_c="$1"

# Cek apakah file C ada
if [ ! -e "$file_c" ]; then
    echo "File $file_c tidak ditemukan."
    exit 1
fi

# Ambil nama file tanpa ekstensi
file_name=$(basename "$file_c" .c)

# Kompilasi file C
gcc -o "$file_name" "$file_c"

# Cek apakah kompilasi berhasil
if [ $? -eq 0 ]; then
    echo "Kompilasi berhasil. Menjalankan $file_name"
    ./"$file_name"
else
    echo "Kompilasi gagal."
fi
