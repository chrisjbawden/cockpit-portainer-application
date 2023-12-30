#!/bin/bash


# Check if the OS is Ubuntu 22 or higher
if [[ $(lsb_release -si) != "Ubuntu" || $(lsb_release -rs | cut -d. -f1) -lt 22 ]]; then
  echo "This script requires Ubuntu 22 or higher."
fi

# Confirm before continuing
read -p "This script is intended for Ubuntu 22 or higher. Do you want to continue? (y/n): " confirm
if [[ $confirm != [Yy] ]]; then
  echo "Script aborted."
  sleep 5
  exit
fi

# Define the target directory
target_directory="/usr/share/cockpit/portainer"
parent_directory="/usr/share/cockpit"

# Check if the upgrade option is provided
if [[ "$1" == "upgrade" ]]; then
  # Check if the target directory exists
  if [ -d "$target_directory" ]; then
    # Delete existing directory
    rm -rf "$target_directory" || echo "Failed to delete existing directory." ; sleep 5 ; exit
  fi
fi

# Check if the target directory exists
if [ -d "$target_directory" ]; then
  # Rename existing directory to 'old'
  mv "$target_directory" "$target_directory.old" || echo "Failed to rename existing directory." ; sleep 5 ; exit
fi

# Create the target directory
#mkdir -p "$target_directory" || error_exit "Failed to create target directory."

# Download the .tar file
tar_url="https://github.com/chrisjbawden/cockpit-portainer-application/releases/download/v1.1-beta/cockpit-portainer-application-1.1-beta.tar"  # Replace with the actual URL
wget "$tar_url" -O /tmp/portainer-temp.tar || error_exit "Failed to download the tar file."

# Extract the .tar file to the target directory
tar -xf /tmp/portainer-temp.tar -C "$parent_directory" --strip-components=1 || error_exit "Failed to extract the tar file."

# Cleanup: Remove the downloaded .tar file
rm /tmp/portainer-temp.tar || error_exit "Failed to remove temporary tar file."

echo "Script executed successfully."
