#!/bin/bash

echo "Enter the version to build and run:"
read VERSION

# Ensure the version input is not empty
if [ -z "$VERSION" ]; then
    echo "Version cannot be empty. Exiting..."
    exit 1
fi

# Define variables for image and container names
IMAGE_NAME="rivkyschon/django_app"
CONTAINER_NAME="django_app"
VOLUME_URL="C:\volumes\db.sqlite3"

# Your Docker build and run commands using the provided version
docker build -t $IMAGE_NAME:$VERSION .

#docker run -d --name django_app-$version -p 5000:5000 --cpus "2.0" --memory "1g" -v rooms:/app/rooms django_app:$version
docker run -d --name $CONTAINER_NAME-$VERSION -p 8000:8000 -v $VOLUME_URL:/app/db.sqlite3 $IMAGE_NAME:$VERSION

# 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
