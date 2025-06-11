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
  echo "Installing 45Drives package: cockpit-$i"

  # Read URLs into array
  mapfile -t CANDIDATE < <(
    curl --fail --retry 15 --retry-all-errors -s "https://api.github.com/repos/$OWNER/cockpit-$i/releases/latest" |
    jq -r '.assets[] | select(.name | endswith(".rpm")) | .browser_download_url'
  )

  EL_MAX=0
  SELECTED=""

  if (( ${#CANDIDATE[@]} > 1 )); then
    for url in "${CANDIDATE[@]}"; do
      # Extract .el version number (RHEL-style RPM naming)
      if [[ "$url" =~ \.el([0-9]+)\. ]]; then
        EL_VERSION="${BASH_REMATCH[1]}"
        if (( EL_VERSION > EL_MAX )); then
          EL_MAX=$EL_VERSION
          SELECTED="$url"
        fi
      fi
    done

    if [[ -n "$SELECTED" ]]; then
      dnf5 -y -q install --setopt=install_weak_deps=False "$SELECTED"
    else
      echo "No valid el* version found in candidates for cockpit-$i"
    fi

  elif (( ${#CANDIDATE[@]} == 1 )); then
    dnf5 -y -q install --setopt=install_weak_deps=False "${CANDIDATE[0]}"
  else
    echo "No RPM found for cockpit-$i"
  fi
done