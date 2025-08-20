#!/bin/bash

# Prompt the user to specify files to add, or press enter to add all
echo "Enter the files to add to the staging area (press enter to add all):"
read FILES_TO_ADD

# If no files are specified, add all changes
if [ -z "$FILES_TO_ADD" ]; then
    echo "No specific files entered. Adding all changes to the staging area..."
    git add --all
else
    echo "Adding specified files to the staging area..."
    git add $FILES_TO_ADD
fi

# Set the commit message
COMMIT_MESSAGE="${1:-Default commit message}"

# Commit with the provided message
echo "Committing changes with message: '$COMMIT_MESSAGE'"
git commit -m "$COMMIT_MESSAGE"

# Attempt to push changes to GitHub
echo "Pushing changes to GitHub..."
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