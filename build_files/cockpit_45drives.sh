#!/usr/bin/env bash

dnf5 -y -q copr enable spike/znapzend >/dev/null 2>&1
dnf5 -y -q --setopt=install_weak_deps=False install znapzend

OWNER="45Drives"
PKGS=(
  zfs-manager
  identities
  file-sharing
)

# Install packages
for i in "${PKGS[@]}"
do 
  echo "Installing 45Drives packages: cockpit-$i"
  dnf5 -y -q install $(
    curl -s https://api.github.com/repos/$OWNER/cockpit-$i/releases/latest |
    jq -r '.assets[] | select(.name | endswith(".rpm")) | .browser_download_url'
  )
done

# Disable znapzend repo
dnf5 -y copr disable spike/znapzend