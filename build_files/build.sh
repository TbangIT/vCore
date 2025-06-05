#!/bin/bash

set -ouex pipefail

### Install packages
bash /ctx/container_policy.sh
bash /ctx/server-packages.sh