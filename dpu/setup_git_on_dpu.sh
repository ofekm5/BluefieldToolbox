#!/bin/bash

# === Configuration ===
GIT_USER_NAME="bluefield-user"
GIT_USER_EMAIL="bluefield@example.com"
GITHUB_REPO_SSH="git@github.com:yourusername/yourrepo.git"
TARGET_DIR="$HOME/my_project"

# === Step 1: Install Git ===
echo "[1/5] Installing Git..."
sudo apt update && sudo apt install -y git

# === Step 2: Configure Git identity ===
echo "[2/5] Configuring Git user..."
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

# === Step 3: Generate SSH key (if doesn't exist) ===
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ ! -f "$SSH_KEY" ]; then
  echo "[3/5] Generating SSH key..."
  ssh-keygen -t ed25519 -C "$GIT_USER_EMAIL" -f "$SSH_KEY" -N ""
else
  echo "[3/5] SSH key already exists, skipping key generation."
fi

# === Step 4: Print public key to add to GitHub ===
echo "[4/5] Add the following public key to your GitHub account:"
echo
cat "${SSH_KEY}.pub"
echo

# === Step 5: Clone the repository (or pull if exists) ===
echo "[5/5] Cloning or updating the repo..."
if [ ! -d "$TARGET_DIR/.git" ]; then
  git clone "$GITHUB_REPO_SSH" "$TARGET_DIR"
else
  cd "$TARGET_DIR" && git pull origin main
fi

echo "✅ Git setup complete."
