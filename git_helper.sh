#!/bin/bash

# Default commit message if none is provided
DEFAULT_MESSAGE="Auto-commit: Updates made on $(date)"

# Display usage information
usage() {
    echo "Usage: $0 [-a] [-f <files>] [-m <message>] [-b <branch>] [-h]"
    echo
    echo "Options:"
    echo "  -a           Add all files (equivalent to 'git add .')."
    echo "  -f <files>   Specify files to add (space-separated list)."
    echo "  -m <message> Commit message (default: '$DEFAULT_MESSAGE')."
    echo "  -b <branch>  Branch to push to (default: current branch)."
    echo "  -h           Show help."
    exit 1
}

# Parse command-line options
ADD_ALL=false
FILES=()
COMMIT_MESSAGE=""
BRANCH=""
while getopts "af:m:b:h" opt; do
    case "$opt" in
        a) ADD_ALL=true ;;
        f) FILES+=("$OPTARG") ;;
        m) COMMIT_MESSAGE="$OPTARG" ;;
        b) BRANCH="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done

# Use default message if no commit message is provided
if [ -z "$COMMIT_MESSAGE" ]; then
    COMMIT_MESSAGE="$DEFAULT_MESSAGE"
    echo "No commit message provided. Using default message: '$COMMIT_MESSAGE'"
fi

# Add files or all files based on options
if [ "$ADD_ALL" = true ]; then
    echo "Adding all files..."
    git add .
elif [ ${#FILES[@]} -gt 0 ]; then
    echo "Adding specified files: ${FILES[*]}"
    git add "${FILES[@]}"
else
    echo "Error: No files specified. Use -a to add all files or -f to specify files."
    usage
fi

# Commit with the provided or default message
echo "Committing with message: '$COMMIT_MESSAGE'"
git commit -m "$COMMIT_MESSAGE"

# Push to the specified branch, or use the current branch if none is provided
if [ -z "$BRANCH" ]; then
    BRANCH=$(git branch --show-current)
    echo "No branch specified. Using current branch: $BRANCH"
else
    echo "Pushing to branch: $BRANCH"
fi

# Push the commit
git push origin "$BRANCH"

echo "Git operations completed successfully!"


