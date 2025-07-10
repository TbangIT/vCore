#!/bin/bash

set -ouex pipefail

bash /ctx/remove-packages.sh

# Install pubkey
curl -o /etc/pki/containers/ta-vroom.pub $(curl -s https://api.github.com/repos/ta-vroom/vcore/releases/latest |  jq -r '.assets[] | select(.name == "cosign.pub") | .browser_download_url')

bash /ctx/server-packages.sh
