#!/bin/bash

echo "Enter the version to build and run:"
read version

# Ensure the version input is not empty
if [ -z "$version" ]; then
    echo "Version cannot be empty. Exiting..."
    exit 1
fi

# Your Docker build and run commands using the provided version
docker build -t django_app:$version .

#docker run -d --name django_app-$version -p 5000:5000 --cpus "2.0" --memory "1g" -v rooms:/app/rooms django_app:$version
docker run -d --name django_app-$version -p 8000:8000 -v myapp_db_volume:/var/lib/docker/volumes/myapp_db_volume/_data django_app:$version

# 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