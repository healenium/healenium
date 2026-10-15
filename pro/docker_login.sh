#!/usr/bin/env bash

set -e

# Load .env file
if [ -f .env ]; then
    source .env
else
    echo "Error: .env file not found"
    exit 1
fi

# Check required variables
if [ -z "$DOCKER_USERNAME" ] || [ -z "$DOCKER_TOKEN" ]; then
    echo "Error: DOCKER_USERNAME or DOCKER_TOKEN is missing in .env"
    exit 1
fi

echo "Logging into Docker Hub..."
echo "$DOCKER_TOKEN" | docker login --username "$DOCKER_USERNAME" --password-stdin

echo
echo "Done."
echo "You can now run: docker compose up -d"