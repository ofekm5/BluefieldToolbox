#!/bin/bash

# Instructions:
# 1. [from the host] transfer this script to the DPU: scp deploy_vnf.sh bluefield@<DPU_IP>:~
# 2. [from the DPU environment] run this script on the DPU:
#    chmod +x ~/deploy_vnf.sh
#    ./deploy_vnf.sh

set -e

# === Prompt for image info ===
read -p "Enter your Docker Hub username: " DOCKERHUB_USER
read -p "Enter the repository name (e.g., vnf_simple_fwd): " REPO_NAME
read -p "Enter the image tag [default: latest]: " TAG
TAG=${TAG:-latest}

IMAGE_NAME="${DOCKERHUB_USER}/${REPO_NAME}:${TAG}"

echo "[1/2] Pulling Docker image: $IMAGE_NAME"
docker pull "$IMAGE_NAME"

echo "[2/2] Running container..."
docker run --rm \
  -v /dev/hugepages:/dev/hugepages \
  --privileged --net=host \
  "$IMAGE_NAME"
