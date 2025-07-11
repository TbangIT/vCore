#!/usr/bin/env bash

RPMFUSION_FREE=https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
RPMFUSION_NONFREE=https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

set ${SET_X:+-x} -eou pipefail

COCKPIT=(
   cockpit
   cockpit-files
   cockpit-networkmanager
   cockpit-podman
   cockpit-selinux
   cockpit-storaged
   cockpit-system
   cockpit-ostree
   cockpit-packagekit
   # Fonts for Cockpit
   adwaita-mono-fonts       
   adwaita-sans-fonts
   # Aurora Logo for branding
   aurora-logos
)

SAMBA=(
   samba
   samba-usershares
)

TERMINAL=(
   fish
   fastfetch
   starship
   zellij
   neovim
   inotify-tools
   tree-sitter-cli
)

MAN=(
   man
   man-pages
   man-db
)

MEDIA=(
   yt-dlp
   ffmpeg
   ffprobe
   #curl_cffi
   AtomicParsley
)

PKGS=(
   libatomic
   podlet
   firewalld
   ipset
   intel-compute-runtime
   intel-media-driver
   zig   
   rclone
   ripgrep
   duperemove
)

PKGS+=( "${MAN[@]}" )
PKGS+=( "${MEDIA[@]}" )
PKGS+=( "${COCKPIT[@]}" )
PKGS+=( "${TERMINAL[@]}" )
PKGS+=( "${RECOVERY[@]}" )

# Install Podling
git clone https://github.com/ta-vroom/podling /tmp/podling
mv /tmp/podling/podling /usr/bin
chmod +x /usr/bin/podling

# Install signing related files
rsync -av /ctx/signing /
curl -L -o /etc/pki/containers/ta-vroom.pub $(
  curl -s https://api.github.com/repos/ta-vroom/vcore/releases/latest |
  jq -r '.assets[] | select(.name | endswith(".pub")) | .browser_download_url'
)

# Enable Repos
dnf5 -y -q copr enable atim/starship >/dev/null 2>&1 
dnf5 -y -q copr enable varlad/zellij >/dev/null 2>&1
dnf5 install -y -q $RPMFUSION_NONFREE # Needed for intel-media-driver
dnf5 config-manager setopt fedora-cisco-openh264.enabled=1 # Needed for rpmfusion_*

# Install Samba
dnf5  --refresh \
      install -y -q \
      "${SAMBA[@]}" \

# Install Packages
dnf5  --refresh \
      --setopt=install_weak_deps=False \
      install -y -q \
      "${PKGS[@]}" \
      --exclude=nodejs-docs,nodejs-full-i18n

# Install 45_drives
/ctx/cockpit_45drives.sh

# Enable Podman and Cockpit
systemctl enable podman.socket
systemctl enable cockpit.socket

# Cleanup
dnf5 config-manager setopt fedora-cisco-openh264.enabled=0
dnf5 copr disable atim/starship
dnf5 copr disable varlad/zellij
dnf5 copr disable ublue-os/packages
dnf5 config-manager setopt rpmfusion-nonfree.enabled=0
dnf5 config-manager setopt rpmfusion-nonfree-updates.enabled=0