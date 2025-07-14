#!/usr/bin/env bash
source /ctx/common

# Create the /nix symlink on the base image
ln -s /var/nix /nix

# Create a tmpfile config to create the /var/nix directory on boot
cat <<EOF > /usr/lib/tmpfiles.d/nix.conf
# Create /var/nix directory
d /var/nix 0755 root root -
EOF

# Enable the Nix Repo
dnf5 -y -q copr enable petersen/nix >/dev/null 2>&1 

# Install Nix
dnf5 install -y -q nix

# Enable the Nix Daemon (to enable Nix for all users)
systemctl enable nix-daemon.service

# Enable Nix MOTD
cat <<EOF > /etc/motd.d/nix
Nix has been installed. To use, add current user to nixusers group
EOF

# Disable the Nix Repo
dnf5 -y -q copr disable petersen/nix >/dev/null 2>&1 