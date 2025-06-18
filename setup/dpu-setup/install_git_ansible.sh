#!/bin/bash

# NOTE: this script intended to be run directly in the DPU environment

# === Step 0: Prompt for Configuration ===
read -p "Enter your GitHub username (for Git identity): " GIT_USER_NAME
read -p "Enter your GitHub email: " GIT_USER_EMAIL
read -p "Enter the local target directory to clone into: " TARGET_DIR
TARGET_DIR="${TARGET_DIR/#\~/$HOME}"  # Expand ~ to $HOME if used

# === Step 1: Install Git ===
echo "[1/6] Installing Git..."
sudo apt update && sudo apt install -y git

# === Step 2: Configure Git identity ===
echo "[2/6] Configuring Git user..."
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

# === Step 3: Generate SSH key (if not exists) ===
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ ! -f "$SSH_KEY" ]; then
  echo "[3/6] Generating SSH key..."
  ssh-keygen -t ed25519 -C "$GIT_USER_EMAIL" -f "$SSH_KEY" -N ""
  eval "$(ssh-agent -s)"
  ssh-add "$SSH_KEY"
else
  echo "[3/6] SSH key already exists, skipping key generation."
fi

# === Step 4: Print public key ===
echo "[4/6] Add the following public key to your GitHub account:"
echo "→ https://github.com/settings/ssh/new"
echo
cat "${SSH_KEY}.pub"
echo
read -p "[Press ENTER after you've added the key to GitHub]"

# === Step 5: Install Ansible ===
echo "[6/6] Installing Ansible..."
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

echo "✅ Git and Ansible setup complete on this machine."
