#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cp -r "$SCRIPT_DIR"/.config "$HOME"
cp -r "$SCRIPT_DIR"/.termux "$HOME"

termux-setup-storage

# Paket dasar
PKGS=(
  neovim
  git
  curl
  wget
  fish

# Build & compiler
  clang
  make
  cmake
  pkg-config

# Runtime & bahasa
  nodejs
  python

# Pencarian & utilitas
  ripgrep
  fd
  eza
  neofetch
  starship

# Parsing & syntax
  tree-sitter

# Utilitas arsip
  unzip
  gzip
  tar

# Bahasa tambahan (opsional)
  rust
  rust-analyzer
  lua-language-server
  shellcheck
)

apt update && apt upgrade -y
apt install "${PKGS[@]}" -y

pip install pynvim

mkdir -p ~/.npm-global
npm config set prefix="$HOME/.npm-global"
# set -Ux PATH $HOME/.npm-global/bin $PATH
