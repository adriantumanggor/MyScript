#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <source_file>"
    exit 1
fi

# Get the source file from the command line arguments
SOURCE_FILE=$1

# Derive the output file name by removing the .cpp extension
OUTPUT_FILE="${SOURCE_FILE%.cpp}"

# Compile the C++ program
g++ -o $OUTPUT_FILE $SOURCE_FILE

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo "Compilation successful. Running the program..."
    # Run the program
    ./$OUTPUT_FILE
else
    echo "Compilation failed."
fi
