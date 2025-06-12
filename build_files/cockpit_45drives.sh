#!/usr/bin/env bash

OWNER="45Drives"

# cockpit plugin for ZFS management
echo "Installing cockpit-zfs-manager" 
curl --fail --retry 15 --retry-all-errors -sSL -o /tmp/cockpit-zfs-manager-api.json \
    "https://api.github.com/repos/45Drives/cockpit-zfs-manager/releases/latest"
CZM_TGZ_URL=$(jq -r .tarball_url /tmp/cockpit-zfs-manager-api.json)
curl --fail --retry 15 --retry-all-errors -sSL -o /tmp/cockpit-zfs-manager.tar.gz "${CZM_TGZ_URL}"

mkdir -p /tmp/cockpit-zfs-manager
tar -zxvf /tmp/cockpit-zfs-manager.tar.gz -C /tmp/cockpit-zfs-manager --strip-components=1 >/dev/null 2>&1
mv /tmp/cockpit-zfs-manager/polkit-1/actions/* /usr/share/polkit-1/actions/
mv /tmp/cockpit-zfs-manager/polkit-1/rules.d/* /usr/share/polkit-1/rules.d/
mv /tmp/cockpit-zfs-manager/zfs /usr/share/cockpit

curl --fail --retry 15 --retry-all-errors -sSL -o /tmp/cockpit-zfs-manager-font-fix.sh \
    https://raw.githubusercontent.com/45Drives/scripts/refs/heads/main/cockpit_font_fix/fix-cockpit.sh
chmod +x /tmp/cockpit-zfs-manager-font-fix.sh
/tmp/cockpit-zfs-manager-font-fix.sh

rm -rf /tmp/cockpit-zfs-manager*
