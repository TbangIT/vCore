#!/bin/bash

set -ouex pipefail

### Install packages

pkgs=(
    intel-media-driver
#   fastfetch firewalld fwupd-efi intel-compute-runtime
#   intel-media-driver neovim podman-compose rclone starship zsh
#   cockpit cockpit-networkmanager cockpit-podman cockpit-selinux
#   cockpit-storaged cockpit-system duperemove samba samba-usershares
)

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1



dnf5 install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
#dnf5 install -y "${pkgs[@]}"

dnf5 install -y intel-media-driver

#### Example for enabling a System Unit File

systemctl enable podman.socket
