#!/bin/bash

# === Check System Date/Time ===
echo "[0/4] Checking current system date and time..."
CURRENT_DATE=$(date)
echo "Current system date/time: $CURRENT_DATE"
echo "If this is incorrect, run: sudo date -s \"YYYY-MM-DD HH:MM:SS\""
echo

# === Step 1: Check and Install Docker ===
echo "[1/4] Checking Docker installation..."
if ! command -v docker &> /dev/null; then
  echo "[+] Docker not found. Installing Docker..."
  sudo apt update
  sudo apt install -y docker.io
  sudo systemctl enable docker
  sudo systemctl start docker
else
  echo "[✓] Docker is already installed: $(docker --version)"
fi
echo

# === Step 2: Check kubelet ===
echo "[2/4] Checking kubelet..."
if [ -f "/usr/bin/kubelet" ]; then
  echo "[✓] kubelet is present at /usr/bin/kubelet"
else
  echo "[!] kubelet not found."
fi
echo

# === Step 3: Check containerd ===
echo "[3/4] Checking containerd..."
if [ -f "/usr/bin/containerd" ]; then
  echo "[✓] containerd is present at /usr/bin/containerd"
else
  echo "[!] containerd not found."
fi
echo

# === Step 4: Check crictl ===
echo "[4/4] Checking crictl..."
if [ -f "/usr/bin/crictl" ]; then
  echo "[✓] crictl is present at /usr/bin/crictl"
else
  echo "[!] crictl not found."
fi

echo
echo "✅ System check completed."
