#!/bin/bash

download_folder="/home/tumanggor675/Downloads"
target_folder="/home/tumanggor675/Downloads/jpg"  

counter=1

# Loop untuk setiap file dengan ekstensi .jpg atau .jpeg di dalam folder unduhan
for file_path in "$download_folder"/*.jpg "$download_folder"/*.jpeg; do
    # Memeriksa keberadaan file dengan nama yang sama di dalam folder tujuan
    while [ -e "$target_folder/$(basename "$file_path")" ]; do
        filename=$(basename "$file_path" .jpg)
        mv "$file_path" "$target_folder/${filename}_$counter.jpg"
        ((counter++))
    done

    # Jika tidak ada konflik, pindahkan file langsung
    mv "$file_path" "$target_folder/"
    echo "File $(basename "$file_path") berhasil dipindahkan ke $target_folder/"
done
