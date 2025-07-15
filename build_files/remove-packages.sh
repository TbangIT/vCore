#!/bin/env bash
source /ctx/common

# Delete Podman Cockpit
rm -rf /usr/lib/systemd/system/cockpit.service

PKGS=(
    tailscale
    NetworkManager-cloud-setup
    amd-gpu-firmware
    nvidia-gpu-firmware
    amd-ucode-firmware
    azure-vm-utils
    google-compute-engine-guest-configs-udev
    cloud-utils-growpart
    moby-engine
    docker-cli
    open-vm-tools
    qemu-guest-agent
)

dnf5 remove -y -q "${PKGS[@]}"

rm -rf /etc/yum.repos.d/tailscale.repo