#!/bin/bash

# Set the commit message
COMMIT_MESSAGE="${1:-Default}"

# Add all changes to the staging area
git add --all

# Commit with the provided message
git commit -m "$COMMIT_MESSAGE"

# Attempt to push changes to GitHub
git push

if [ $? -ne 0 ]; then
    # If push fails because there is no upstream branch, set the upstream branch
    echo "Push failed. Attempting to set upstream branch..."
    current_branch=$(git branch --show-current)
    git push --set-upstream origin "$current_branch"
    
    # Check push status again
    if [ $? -eq 0 ]; then
        echo "Changes successfully committed and pushed to GitHub after setting upstream branch."
    else
        echo "Failed to set upstream branch and push changes."
    fi
else
    echo "Changes successfully committed and pushed to GitHub."
fi
