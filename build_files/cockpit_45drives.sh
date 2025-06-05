#!/usr/bin/env bash

# cockpit-zfs-manager is already installed in /usr/share/cockpit, but not as a .rpm
# not sure if there is any benefit to installing it this way, but here it is
if false; then
  dnf5 -y -q copr enable spike/znapzend >/dev/null 2>&1
  dnf5 -y -q --setopt=install_weak_deps=False install znapzend

  dnf5 -y -q install $(
    curl -s https://api.github.com/repos/45Drives/cockpit-zfs-manager/releases/latest |
    jq -r '.assets[] | select(.name | endswith(".rpm")) | .browser_download_url'
  )
fi

# This is a RHEL variable, not present in Fedora
# TODO::Look into automating this 
RELEASEVER=9

# Install the 45drives repo
dnf5 config-manager addrepo \
    --set=baseurl=https://repo.45drives.com/enterprise/rocky/el$RELEAEVER/stable/x86_64 \
    --id=45drives_enterprise \
    --set=name="45Drives Enterprise $RELEASEVER Repo" \
    --set=enabled=1 \
    --set=gpgcheck=1 \
    --set=gpgkey=https://repo.45drives.com/key/gpg.asc

# Install other 45drive cockpit modules
dnf5 install -y -q --setopt=install_weak_deps=False cockpit-45drives-hardware cockpit-navigator cockpit-file-sharing

# Disable znapzend repo
dnf5 -y copr disable spike/znapzend

# Disable 45drives repo
dnf5 config-manager setopt 45drives_enterprise.enabled=0 