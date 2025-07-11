#!/usr/bin/env bash
source /ctx/common

# Enable Repos
dnf5 -y -q copr enable atim/starship >/dev/null 2>&1 
dnf5 -y -q copr enable varlad/zellij >/dev/null 2>&1

PKGS=(
   fish
   fastfetch
   starship
   zellij
   neovim
   inotify-tools
   tree-sitter-cli
)

DNF "${PKGS[@]}"

dnf5 copr disable atim/starship
dnf5 copr disable varlad/zellij