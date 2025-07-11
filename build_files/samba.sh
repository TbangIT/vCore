#!/usr/bin/env bash
source /ctx/common

PKGS=(
   samba
   samba-usershares
)

DNF "${PKGS[@]}"