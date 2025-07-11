#!/usr/bin/env bash
source /ctx/common

MEDIA=(
   yt-dlp
   ffmpeg
   ffprobe
   #curl_cffi
   AtomicParsley
)

PKGS=(
   podlet
   ipset
   zig   
   rclone
   ripgrep
   duperemove
)

PKGS+=( "${MEDIA[@]}" )

# Install Packages
DNF "${PKGS[@]}"

# Install 45_drives
# bash is required to execute scripts
bash /ctx/cockpit_45drives.sh

# Enable Podman
systemctl enable podman.socket

dnf5 copr disable ublue-os/packages