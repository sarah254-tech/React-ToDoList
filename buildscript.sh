#!/bin/bash

echo "Logging into Docker Hub..."
echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin

# Build backend image
docker build -t $USERNAME/ci_backend_full_pipeline:v1 \
  -f backend/Dockerfile backend

# Build frontend image
docker build -t $USERNAME/ci_frontend_full_pipeline:v1 \
  -f dive-react-app/Dockerfile dive-react-app

# Push images
docker push $USERNAME/ci_backend_full_pipeline:v1
docker push $USERNAME/ci_frontend_full_pipeline:v1

