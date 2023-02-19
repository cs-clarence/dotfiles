#!/bin/bash
#
# Update existing packages
sudo dnf update --refresh -y
sudo flatpak update

source ./core.sh

# Install the core tools
if [[ ${#to_be_installed[@]} > 0 ]]; then
	echo "Running install commands"

	for cmd in install_commands; do
		eval $cmd
	done

	echo "Running post-installation commands"

	for cmd in "${to_be_run[@]}"; do
		eval $cmd
	done
else
	echo "All tools are installed already"
fi
