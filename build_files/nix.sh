#!/usr/bin/env bash
source /ctx/common

cat <<EOF > /etc/tmpfiles.d/prepare-nix-mount.service
[Unit]
Description=Create mount point for Nix Store
Before=nix.mount

[Service]
Type=oneshot
ExecStart=/usr/bin/mkdir -p /nix /var/nix
RemainAfterExit=true

[Install]
WantedBy=multi-user.target
EOF


cat <<EOF > /usr/lib/systemd/nix.mount
[Unit]
Description=Bind mount /var/nix to /nix
Before=local-fs.target

[Mount]
What=/var/nix
Where=/nix
Type=none
Options=bind

[Install]
WantedBy=local-fs.target
EOF

systemctl enable prepare-nix-mount.service
systemctl enable nix.mount

dnf5 copr enable petersen/nix

dnf5 install -y -q nix

systemctl enable nix-daemon.service