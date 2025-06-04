#!/usr/bin/env bash

RPMFUSION_FREE=https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
RPMFUSION_NONFREE=https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

set ${SET_X:+-x} -eou pipefail

COCKPIT=(
   cockpit
   cockpit-networkmanager
   cockpit-podman
   cockpit-selinux
   cockpit-storaged
   cockpit-system
   cockpit-ostree
   # Fonts for Cockpit
   adwaita-mono-fonts       
   adwaita-sans-fonts
   # Aurora Logo for branding
   aurora-logos
)

SAMBA=(
   samba
   samba-usershares
)

TERMINAL=(
   zsh
   fastfetch
   starship
   neovim
   inotify-tools
   tree-sitter-cli
)

PKGS=(
   libatomic
   firewalld
   ipset
   intel-compute-runtime
   intel-media-driver
   podman-compose
   rclone
   ripgrep
   duperemove
   $COCKPIT
   $SAMBA
   $TERMINAL
)

# Enable Repos
dnf5 -y -q copr enable atim/starship
dnf5 install -y -q $RPMFUSION_NONFREE # Needed for intel-media-driver
dnf5 config-manager setopt fedora-cisco-openh264.enabled=1 # Needed for rpmfusion_*

# Install 45Drive Cockpit Packages 
bash /ctx/cockpit_45drives.sh

# Install Packages
dnf5  --refresh \
      --setopt=install_weak_deps=False \
      install -y -q "${PKGS[@]}" \
      --exclude=nodejs-docs,nodejs-full-i18n

# Enable Podman and Cockpit
systemctl enable podman.socket
systemctl enable cockpit.socket

#Cleanup
dnf5 config-manager setopt fedora-cisco-openh264.enabled=0
dnf5 copr disable atim/starship
dnf5 copr disable ublue-os/packages
dnf5 config-manager setopt rpmfusion-nonfree.enabled=0
dnf5 config-manager setopt rpmfusion-nonfree-updates.enabled=0