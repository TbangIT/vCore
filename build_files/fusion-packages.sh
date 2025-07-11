#!/usr/bin/env bash
source /ctx/common

RPMFUSION_FREE=https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
RPMFUSION_NONFREE=https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

INTEL_DRIVERS=(
   intel-compute-runtime
   intel-media-driver
)

PKGS=()

PKGS+=( "${INTEL_DRIVERS[@]}" )

# Enable Repos
dnf5 config-manager setopt fedora-cisco-openh264.enabled=1 # Needed for rpmfusion_*
#dnf5 install -y -q $RPMFUSION_FREE 
dnf5 install -y -q $RPMFUSION_NONFREE # Needed for intel-media-driver

DNF "${PKGS[@]}"

# Disable repos
dnf5 config-manager setopt fedora-cisco-openh264.enabled=0
dnf5 config-manager setopt rpmfusion-nonfree.enabled=0
dnf5 config-manager setopt rpmfusion-nonfree-updates.enabled=0