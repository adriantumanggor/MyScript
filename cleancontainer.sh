#!/bin/bash

# Get a list of all image IDs that have <none> in the repository or tag
images_to_remove=$(docker images --filter "dangling=true" -q)

# Check if there are any images to remove
if [ -z "$images_to_remove" ]; then
    echo "No unused images found."
else
    # Remove the unused images
    echo "Removing unused images..."
    docker rmi $images_to_remove
    echo "Unused images have been removed."
fi
                    