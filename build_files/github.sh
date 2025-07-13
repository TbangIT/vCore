#!/bin/env bash

BIN_DIR=/usr/bin

dnf5 install -y -q wget

wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz
sudo chmod +x eza
sudo chown root:root eza
sudo mv eza /usr/bin/eza