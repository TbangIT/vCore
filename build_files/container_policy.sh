#!/bin/bash

set -ouex pipefail

# Check if the key exists using jq safely (avoid command substitution inside if)
if jq -e '.transports.docker["ghcr.io/ta-vroom]' /etc/containers/policy.json > /dev/null; then
  echo "Policy for ghcr.io/ta-vroom already exists"
  exit 0
else 
  echo "Adding policy for ghcr.io/ta-vroom"

  jq '.transports.docker["ghcr.io/ta-vroom"] = [
    {
        "type": "sigstoreRepository",
        "signedIdentity": {
            "type": "exactMatch",
            "identity": "https://github.com/ta-vroom/vcore/.github/workflows/build.yml@refs/heads/main"
        }
    }
  ]' /etc/containers/policy.json > /tmp/policy.json

mv /tmp/policy.json /etc/containers/policy.json

  # Validate JSON
  jq empty /etc/containers/policy.json
fi