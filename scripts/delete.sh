#!/bin/bash
read -p "Enter the version to delete:" VERSION
 
# Ensure the version input is not empty
if [ -z "$VERSION" ]; then
    echo "Version cannot be empty. Exiting..."
    exit 1
fi

# Delete the Docker container using the provided version
docker rm -f django_app-$VERSION

# Delete the Docker image using the provided version
docker rmi django_app:$VERSION


