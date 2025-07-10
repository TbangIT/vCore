#!/bin/bash

set -ouex pipefail

# Delete Podman Cockpit
rm -rf /usr/lib/systemd/system/cockpit.service

RM=(
    NetworkManager-cloud-setup
    amd-gpu-firmware
    nvidia-gpu-firmware
    amd-ucode-firmware
    azure-vm-utils
    google-compute-engine-guest-configs-udev
    cloud-utils-growpart
    moby-engine
    docker-cli
)

dnf5 install -y -q "${RM[@]}"