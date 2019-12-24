#!/usr/bin/env bash

set -e

source ./../config.sh

docker build -t ${repo_name}-userlayer --build-arg from=${repo_name}:latest .
docker tag ${repo_name}-userlayer ${repo_name}-userlayer:${tag}

docker push ${repo_name}-userlayer
docker push ${repo_name}-userlayer:${tag}