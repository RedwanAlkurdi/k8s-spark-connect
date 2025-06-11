#!/bin/bash

# Colors for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Prompt for image name and version
read -p "Enter the image name (e.g., your-registry/spark-connect-client): " IMAGE_NAME
if [ -z "$IMAGE_NAME" ]; then
    echo -e "${RED}Error: Image name cannot be empty${NC}"
    exit 1
fi

read -p "Enter the version tag (e.g., 1.0.0): " VERSION_TAG
if [ -z "$VERSION_TAG" ]; then
    echo -e "${RED}Error: Version tag cannot be empty${NC}"
    exit 1
fi

# Simple Docker login check
if ! docker info 2>/dev/null | grep "Username:" >/dev/null; then
    echo -e "${YELLOW}You are not logged in to Docker registry${NC}"
    echo -e "Please login to continue:"
    docker login
    if [ $? -ne 0 ]; then
        echo -e "${RED}Login failed. Exiting...${NC}"
        exit 1
    fi
fi

# Build the image for linux platform
echo -e "${GREEN}Building Docker image for linux platform...${NC}"
docker buildx build --push --platform linux/amd64 -t "${IMAGE_NAME}:${VERSION_TAG}" . & docker push "${IMAGE_NAME}:${VERSION_TAG}"

if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Docker build failed${NC}"
    exit 1
fi
