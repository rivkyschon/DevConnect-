#!/bin/bash
read -p "Enter the version to delete:" VERSION
 
# Ensure the version input is not empty
if [ -z "$VERSION" ]; then
    echo "Version cannot be empty. Exiting..."
    exit 1
fi

IMAGE_NAME="rivkyschon/django_app"
CONTAINER_NAME="django_app"

# Delete the Docker container using the provided version
docker rm -f $CONTAINER_NAME-$VERSION

# Delete the Docker image using the provided version
docker rmi $IMAGE_NAME:$VERSION


