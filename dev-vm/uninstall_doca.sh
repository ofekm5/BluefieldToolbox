#!/bin/bash

echo "🔍 Searching for old DOCA-related packages to remove..."

# Get matching packages
packages=$(dpkg --list | grep -E 'doca|flexio|dpa-gdbserver|dpa-stats|dpaeumgmt' | awk '{print $2}')

if [ -z "$packages" ]; then
  echo "✅ No DOCA-related packages found."
else
  echo "📦 Found the following packages:"
  echo "$packages"
  echo "🚮 Removing packages..."
  for pkg in $packages; do
    echo "→ Removing $pkg..."
    sudo apt remove --purge -y "$pkg"
  done
fi

# Uninstall OFED if script exists
if [ -x /usr/sbin/ofed_uninstall.sh ]; then
  echo "🧼 Running OFED uninstall script..."
  sudo /usr/sbin/ofed_uninstall.sh --force
else
  echo "ℹ️  OFED uninstall script not found. Skipping."
fi

echo "🧹 Running apt autoremove..."
sudo apt-get autoremove -y

echo "✅ Cleanup complete."
