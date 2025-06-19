#!/bin/bash

# Instructions:
# 1. [from the host] transfer this script to the DPU: scp install_docker.sh <DPU_USER>@<DPU_IP>:<remote/destination/path>

# 2. [from the DPU environment] run this script on the DPU:
# chmod +x ~/install_docker.sh
# ./install_docker.sh

# === Step 1: Install Docker ===
echo "[1/3] Installing Docker..."
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

# === Step 2: (Optional) Docker Hub login ===
# read -p "Is your Docker image private? [y/N]: " is_private
# if [[ "$is_private" =~ ^[Yy]$ ]]; then
#   read -p "Docker Hub username: " docker_user
#   read -s -p "Docker Hub password: " docker_pass
#   echo
#   echo "$docker_pass" | docker login --username "$docker_user" --password-stdin
# fi