#!/usr/bin/env python3

import os
import shutil

download_folder = "/home/username/Downloads"
target_folder = "/home/username/Downloads/jpg"

counter = 1

# Loop untuk setiap file dengan ekstensi .jpg atau .jpeg di dalam folder unduhan
for file_name in os.listdir(download_folder):
    if file_name.lower().endswith(('.jpg', '.jpeg')):
        file_path = os.path.join(download_folder, file_name)

        # Memeriksa keberadaan file dengan nama yang sama di dalam folder tujuan
        while os.path.exists(os.path.join(target_folder, file_name)):
            file_name, file_extension = os.path.splitext(file_name)
            new_file_name = f"{file_name}_{counter}{file_extension}"
            counter += 1
            file_name = new_file_name

        # Pindahkan file langsung
        shutil.move(file_path, os.path.join(target_folder, file_name))
        print(f"File {file_name} berhasil dipindahkan ke {target_folder}")
