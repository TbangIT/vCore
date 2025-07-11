#!/bin/env bash
source /ctx/common

# Install Podling
git clone https://github.com/ta-vroom/podling /tmp/podling
mv /tmp/podling/podling /usr/bin
chmod +x /usr/bin/podling

# Remove ublue-os signing
# These should be overwritten below, but in case something goes wrong
dnf5 remove -y -q ublue-os-signing.noarch

# Install signing related files
cp /ctx/signing/etc/containers/registries.d/ta-vroom.yaml /etc/containers/registries.d
cp /ctx/signing/etc/containers/policy.json /etc/containers

curl -L -o /etc/pki/containers/ta-vroom.pub $(
  curl -s https://api.github.com/repos/ta-vroom/vcore/releases/latest |
  jq -r '.assets[] | select(.name | endswith(".pub")) | .browser_download_url'
)
