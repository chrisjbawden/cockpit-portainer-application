#!/bin/bash

# Suppress command output
exec &> /dev/null

# Check if the OS is Ubuntu 22 or higher
if [ "$(lsb_release -si)" != "Ubuntu" ]; then
  echo ""
  echo "This script was created for Ubuntu"
  echo ""

  # Confirm before continuing
  read -p "This script is intended for Ubuntu - Do you want to continue? (y/n): " confirm
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo ""
    echo "Script aborted."
    sleep 5
    exit 1
  fi
fi

# Set target directory
target_directory="/usr/share/cockpit/portainer"

# Check if the upgrade option is provided
if [ "$1" = "upgrade" ]; then
  if [ -d "$target_directory" ]; then
    rm -rf "$target_directory" || { echo "Failed to delete existing directory."; sleep 5; exit 1; }
  fi
fi

# If target directory exists, back it up
if [ -d "$target_directory" ]; then
  mv "$target_directory" "${target_directory}.old" || { echo "Failed to rename existing directory."; sleep 5; exit 1; }
fi

# Download the .tar file
tar_url="https://github.com/chrisjbawden/cockpit-portainer-application/raw/refs/heads/main/portainer.tar"
wget "$tar_url" -O portainer.tar

# Create the target directory
mkdir -p "$target_directory"

# Extract contents directly into the target directory
tar -xf portainer.tar -C "$target_directory"

# Cleanup
rm portainer.tar

echo ""
echo ""
echo "Portainer app deployed successfully to $target_directory"
echo ""
echo ""
