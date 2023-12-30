#!/bin/bash

# Function to display an error message and exit
function error_exit {
  echo "$1" >&2
  exit 1
}

# Check if the OS is Ubuntu 22 or higher
if [[ $(lsb_release -si) != "Ubuntu" || $(lsb_release -rs | cut -d. -f1) -lt 22 ]]; then
  error_exit "This script requires Ubuntu 22 or higher. Aborting."
fi

# Confirm before continuing
read -p "This script is intended for Ubuntu 22 or higher. Do you want to continue? (y/n): " confirm
if [[ $confirm != [Yy] ]]; then
  error_exit "Script aborted."
fi

# Define the target directory
target_directory="/usr/share/cockpit/portainer"
parent_directory="/usr/share/cockpit"

# Check if the upgrade option is provided
if [[ "$1" == "upgrade" ]]; then
  # Check if the target directory exists
  if [ -d "$target_directory" ]; then
    # Delete existing directory
    rm -rf "$target_directory" || error_exit "Failed to delete existing directory."
  fi
fi

# Check if the target directory exists
if [ -d "$target_directory" ]; then
  # Rename existing directory to 'old'
  mv "$target_directory" "$target_directory.old" || error_exit "Failed to rename existing directory."
fi

# Create the target directory
#mkdir -p "$target_directory" || error_exit "Failed to create target directory."

# Download the .tar file
tar_url="https://example.com/path/to/your/file.tar"  # Replace with the actual URL
wget "$tar_url" -O /tmp/portainer-temp.tar || error_exit "Failed to download the tar file."

# Extract the .tar file to the target directory
tar -xf /tmp/portainer-temp.tar -C "$parent_directory" --strip-components=1 || error_exit "Failed to extract the tar file."

# Cleanup: Remove the downloaded .tar file
rm /tmp/portainer-temp.tar || error_exit "Failed to remove temporary tar file."

echo "Script executed successfully."
