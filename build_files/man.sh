#!/usr/bin/env bash
source /ctx/common

PKGS=(
   man
   man-pages
   man-db
)

DNF "${PKGS[@]}"