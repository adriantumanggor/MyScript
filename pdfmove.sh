#!/bin/bash

download_folder="/home/tumanggor675/Downloads"
target_folder="/home/tumanggor675/Downloads/pdf"  

counter=1

# Loop untuk setiap file dengan ekstensi .pdf
for file_path in "$download_folder"/*.pdf ; do
    # Memeriksa keberadaan file dengan nama yang sama di dalam folder tujuan
    while [ -e "$target_folder/$(basename "$file_path")" ]; do
        filename=$(basename "$file_path" .pdf)
        mv "$file_path" "$target_folder/${filename}_$counter.pdf"
        ((counter++))
    done

    # pindahkan file 
    mv "$file_path" "$target_folder/"
    echo "File $(basename "$file_path") berhasil dipindahkan ke $target_folder/"
done
