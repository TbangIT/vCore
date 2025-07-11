#!/usr/bin/env bash
source /ctx/common

PKGS=(
   cockpit
   cockpit-files
   cockpit-storaged
   cockpit-ostree
   cockpit-packagekit
   # Fonts for Cockpit
   adwaita-mono-fonts       
   adwaita-sans-fonts
   # Aurora Logo for branding
   aurora-logos
)

# Install Packages
DNF "${PKGS[@]}"

systemctl enable cockpit.socket
