#!/bin/bash

# Instructions:
# 1. scp this script to the DPU: scp check_and_install_docker_k8s.sh <DPU_USER>@<DPU_IP>:~
# 2. On the DPU: chmod +x check_and_install_docker_k8s.sh && ./check_and_install_docker_k8s.sh

echo "=== [0/4] Checking prerequisites ==="

# === Check Docker ===
if command -v docker &> /dev/null; then
    echo "[✓] Docker is already installed: $(docker --version)"
else
    echo "[1/4] Docker not found. Installing Docker..."
    sudo apt update
    sudo apt install -y docker.io
    sudo systemctl enable docker
    sudo systemctl start docker
    echo "[✓] Docker installed successfully."
fi

# === Check kubelet ===
if command -v kubelet &> /dev/null; then
    echo "[✓] kubelet found: $(kubelet --version)"
else
    echo "[!] kubelet is not installed. This node cannot join a Kubernetes cluster unless it's configured manually."
fi

# === Check containerd ===
if command -v containerd &> /dev/null; then
    echo "[✓] containerd found: $(containerd --version | head -n 1)"
else
    echo "[!] containerd is not installed. Some runtimes may not function properly."
fi

# === Check crictl ===
if command -v crictl &> /dev/null; then
    echo "[✓] crictl found: $(crictl --version)"
else
    echo "[!] crictl is not installed. Not critical unless doing container runtime debugging."
fi

echo "=== [✓] Environment check complete ==="
