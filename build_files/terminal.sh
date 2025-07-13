#!/usr/bin/env bash
source /ctx/common

# Enable Repos
dnf5 -y -q copr enable atim/starship >/dev/null 2>&1 
dnf5 -y -q copr enable varlad/zellij >/dev/null 2>&1

RUST=(
    ripgrep # grep
    fd-find # find
    bat # cat
    zoxide # cd
    dust # du search what takes space
    duf # df see storage available
    zellij # tmux
)


PKGS+=( "${RUST[@]}" )

PKGS=(
   fish # Shell
   fastfetch # Neofetch alt.
   rclone 
   starship 
   neovim
   inotify-tools
   tree-sitter-cli
)

DNF "${PKGS[@]}"

dnf5 copr disable atim/starship
dnf5 copr disable varlad/zellij