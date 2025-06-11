#!/usr/bin/env bash

OWNER="45Drives"
PKGS=(
  identities
  file-sharing
)

# cockpit plugin for ZFS management
curl --fail --retry 15 --retry-all-errors -sSL -o /tmp/cockpit-zfs-manager-api.json \
    "https://api.github.com/repos/45Drives/cockpit-zfs-manager/releases/latest"
CZM_TGZ_URL=$(jq -r .tarball_url /tmp/cockpit-zfs-manager-api.json)
curl --fail --retry 15 --retry-all-errors -sSL -o /tmp/cockpit-zfs-manager.tar.gz "${CZM_TGZ_URL}"

mkdir -p /tmp/cockpit-zfs-manager
tar -zxvf /tmp/cockpit-zfs-manager.tar.gz -C /tmp/cockpit-zfs-manager --strip-components=1
mv /tmp/cockpit-zfs-manager/polkit-1/actions/* /usr/share/polkit-1/actions/
mv /tmp/cockpit-zfs-manager/polkit-1/rules.d/* /usr/share/polkit-1/rules.d/
mv /tmp/cockpit-zfs-manager/zfs /usr/share/cockpit

curl --fail --retry 15 --retry-all-errors -sSL -o /tmp/cockpit-zfs-manager-font-fix.sh \
    https://raw.githubusercontent.com/45Drives/scripts/refs/heads/main/cockpit_font_fix/fix-cockpit.sh
chmod +x /tmp/cockpit-zfs-manager-font-fix.sh
/tmp/cockpit-zfs-manager-font-fix.sh

rm -rf /tmp/cockpit-zfs-manager*

# Install packages
for i in "${PKGS[@]}"
do 
  echo "Installing 45Drives packages: cockpit-$i"
  dnf5 -y -q install $(
    curl -s https://api.github.com/repos/$OWNER/cockpit-$i/releases/latest |
    jq -r '.assets[] | select(.name | endswith(".rpm")) | .browser_download_url'
  )
done
