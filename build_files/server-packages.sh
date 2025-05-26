#!/usr/bin/env bash

set ${SET_X:+-x} -eou pipefail


PKGS=(
   fastfetch firewalld fwupd-efi intel-compute-runtime
   intel-media-driver neovim podman-compose rclone starship zsh
   cockpit cockpit-networkmanager cockpit-podman cockpit-selinux
   cockpit-storaged cockpit-system duperemove samba samba-usershares
)

dnf5 -y -q copr enable atim/starship
dnf5 install -y -q https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm > /dev/null

dnf5 config-manager setopt fedora-cisco-openh264.enabled=1

#/ctx/cockpit_45drives.sh

dnf5 install -y -q "${PKGS[@]}"

# Enable Podman and Cockpit
systemctl enable podman.socket
systemctl enable cockpit.socket