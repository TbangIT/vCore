#!/usr/bin/env bash
source /ctx/common

PKGS=(
   ipset
   zig   
   duperemove
)

# Install Packages
DNF "${PKGS[@]}"

# Install 45_drives
# bash is required to execute scripts
bash /ctx/cockpit_45drives.sh

# Enable Podman
systemctl enable podman.socket

dnf5 copr disable ublue-os/packages