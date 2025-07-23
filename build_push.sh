#!/bin/bash
set -e -x -u

# bash script should be called with the following environment variables set:
# * DOCKER_SERVER: ECR repo domain

DOCKER_REPO="$DOCKER_SERVER/cms-sync"

# build docker image and tag it with git hash and aws environment
githash=$(git rev-parse --short HEAD)
docker build -t cms-sync:latest .
docker tag cms-sync:latest $DOCKER_REPO:git-$githash
docker tag cms-sync:latest $DOCKER_REPO:latest

# get ECR credentials
aws ecr get-login-password --region us-east-1 \
    | docker login --username AWS \
        --password-stdin $DOCKER_SERVER

# push images to ECS image repo
docker push $DOCKER_REPO:latest
docker push $DOCKER_REPO:git-$githash
