#!/bin/bash

# Check if .env file exists
if [ ! -f .env ]; then
    echo ".env file not found!"
    exit 1
fi

# Load environment variables
source .env

# Prompt for environment type
read -p "Enter environment type (dev/prod): " ENV_TYPE

# Create docker-compose.yml from template
cp docker-compose-template.yml docker-compose.yml

# Replace environment-specific variables
sed -i "s/ENV_TYPE/$ENV_TYPE/g" docker-compose.yml

# Create necessary directories
mkdir -p logs
mkdir -p data

# Start Docker containers
docker-compose up -d --build

echo "Docker environment set up for $ENV_TYPE environment."
