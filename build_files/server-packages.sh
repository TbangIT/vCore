#!/usr/bin/env bash

RPMFUSION_FREE=https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
RPMFUSION_NONFREE=https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

set ${SET_X:+-x} -eou pipefail

COCKPIT=(
   cockpit
   cockpit-files
   cockpit-networkmanager
   cockpit-podman
   cockpit-selinux
   cockpit-storaged
   cockpit-system
   cockpit-ostree
   cockpit-packagekit
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
   fish
   nix
   yt-dlp
   fastfetch
   starship
   zellij
   neovim
   inotify-tools
   tree-sitter-cli
)

PKGS=(
   systemd-boot-unsigned
   man-pages
   man-db
   libatomic
   podlet
   firewalld
   ipset
   intel-compute-runtime
   intel-media-driver
   zig   
   rclone
   ripgrep
   duperemove
)

# Install sd-bootc, a small script to help with systemd-boot
dnf5 -y -q install $(
 curl -s https://api.github.com/repos/ta-vroom/sd-bootc/releases/latest |
 jq -r '.assets[] | select(.name | endswith(".rpm")) | .browser_download_url'
)

PKGS+=( "${COCKPIT[@]}" )
PKGS+=( "${TERMINAL[@]}" )
PKGS+=( "${RECOVERY[@]}" )

# Enable Repos
dnf5 -y -q copr enable atim/starship >/dev/null 2>&1 
dnf5 -y -q copr enable varlad/zellij >/dev/null 2>&1
dnf5 install -y -q $RPMFUSION_NONFREE # Needed for intel-media-driver
dnf5 config-manager setopt fedora-cisco-openh264.enabled=1 # Needed for rpmfusion_*

# Enable Nix
sudo dnf -y -q copr enable petersen/nix > /dev/null 2>&1

# Install 45Drive Cockpit Packages 
bash /ctx/cockpit_45drives.sh

# Install Samba
dnf5  --refresh \
      install -y -q \
      "${SAMBA[@]}" \

# Install Packages
dnf5  --refresh \
      --setopt=install_weak_deps=False \
      install -y -q \
      "${PKGS[@]}" \
      --exclude=nodejs-docs,nodejs-full-i18n

# Enable Podman and Cockpit
systemctl enable podman.socket
systemctl enable cockpit.socket
systemctl enable nix-daemon
systemctl enable sd-bootc.service

# Cleanup
dnf5 config-manager setopt fedora-cisco-openh264.enabled=0
dnf5 copr disable atim/starship
dnf5 copr disable varlad/zellij
sudo dnf copr disable petersen/nix
dnf5 copr disable ublue-os/packages
dnf5 config-manager setopt rpmfusion-nonfree.enabled=0
dnf5 config-manager setopt rpmfusion-nonfree-updates.enabled=0
