#!/bin/bash

# Instructions:
# 1. [from the host] transfer this script to the DPU: scp deploy_vnf.sh bluefield@<DPU_IP>:~
# 2. [from the DPU environment] run this script on the DPU:
# chmod +x ~/deploy_vnf.sh
# ./deploy_vnf.sh

# === Pull and run the VNF container ===
IMAGE_NAME="yourdockerhubuser/vnf_simple_fwd:latest"
echo "[3/3] Pulling and running $IMAGE_NAME..."
docker pull "$IMAGE_NAME"

docker run --rm \
  -v /dev/hugepages:/dev/hugepages \
  --privileged --net=host \
  "$IMAGE_NAME"
