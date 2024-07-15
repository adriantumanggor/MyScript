#!/bin/bash

# Fungsi untuk menanyakan dan menambahkan library tambahan
function add_libraries() {
    echo "Pilih library tambahan yang ingin Anda tambahkan (pisahkan dengan spasi):"
    echo "1) MySQL"
    echo "2) pthread"
    echo "3) math"
    echo "4) curl"
    echo "5) gtk"
    echo "6) OpenGL"
    echo "0) Tidak ada library tambahan"

    read -a selections

    libraries=""

    for selection in "${selections[@]}"; do
        case $selection in
            1)
                libraries="$libraries -lmysqlclient -I/usr/include/mysql -L/usr/lib/mysql"
                ;;
            2)
                libraries="$libraries -lpthread"
                ;;
            3)
                libraries="$libraries -lm"
                ;;
            4)
                libraries="$libraries -lcurl"
                ;;
            5)
                libraries="$libraries -lgtk-3"
                ;;
            6)
                libraries="$libraries -lGL -lGLU -lglut"
                ;;
            0)
                break
                ;;
            *)
                echo "Pilihan tidak valid: $selection"
                ;;
        esac
    done

    echo $libraries
}

# Cek apakah argumen file C telah diberikan
if [ $# -eq 0 ]; then
    echo "Usage: $0 <source_files.c>"
    exit 1
fi

# Kumpulkan semua file C dari argumen
source_files=""
for file in "$@"; do
    if [ ! -e "$file" ]; then
        echo "File $file tidak ditemukan."
        exit 1
    fi
    source_files="$source_files $file"
done

# Ambil nama file eksekusi dari file pertama (tanpa ekstensi)
file_name=$(basename "$1" .c)

# Tambahkan library tambahan
# additional_libs=$(add_libraries)

# Kompilasi file-file C dengan library tambahan
gcc -o "$file_name" $source_files $additional_libs

# Cek apakah kompilasi berhasil
if [ $? -eq 0 ]; then
    echo "Kompilasi berhasil. Menjalankan $file_name"
    ./"$file_name"
else
    echo "Kompilasi gagal."
fi
