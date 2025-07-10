#!/bin/bash

set ${SET_X:+-x} -eou pipefail

# Delete Podman Cockpit
rm -rf /usr/lib/systemd/system/cockpit.service



RM=(
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
)

dnf5 remove -y -q "${RM[@]}"

rm -rf /etc/yum.repos.d/tailscale.repo