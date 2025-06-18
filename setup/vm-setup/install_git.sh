#!/bin/bash

# === Step 1: Install Git ===
echo "[+] Installing Git..."
sudo apt update && sudo apt install -y git

# === Step 2: Set up Git identity ===
echo "[+] Configuring Git identity..."
read -p "Enter your GitHub username: " gh_user
read -p "Enter your GitHub email: " gh_email
git config --global user.name "$gh_user"
git config --global user.email "$gh_email"

# === Step 3: Generate SSH key (if not already exists) ===
if [ ! -f ~/.ssh/id_rsa ]; then
  echo "[+] Generating SSH key..."
  ssh-keygen -t rsa -b 4096 -C "$gh_email" -N "" -f ~/.ssh/id_rsa
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
else
  echo "[+] SSH key already exists."
fi

# === Step 4: Display public key for GitHub ===
echo "[*] Copy the following SSH key to your GitHub account:"
echo "   → https://github.com/settings/ssh/new"
echo
cat ~/.ssh/id_rsa.pub
echo
read -p "[Press ENTER after you've added the key to GitHub]"

# === Step 5: Test connection to GitHub ===
echo "[+] Testing GitHub SSH connection..."
ssh -T git@github.com
