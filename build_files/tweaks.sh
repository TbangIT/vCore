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
ls -l /ctx/signing
cp /ctx/signing/ta-vroom.yaml /etc/containers/registries.d/ta-vroom.yaml
cp /ctx/signing/policy.json /etc/containers/policy.json
cp /ctx/signing/cosign.pub /etc/pki/containers/ta-vroom.pub