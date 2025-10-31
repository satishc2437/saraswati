#!/usr/bin/env bash
# check-git-config.sh
# Fails if user.name or user.email are not set locally or globally.
set -euo pipefail

name=$(git config user.name || true)
email=$(git config user.email || true)

global_name=$(git config --global user.name || true)
global_email=$(git config --global user.email || true)

if [[ -z "$name" && -z "$global_name" ]]; then
  echo "[pre-commit] ERROR: git user.name is not set (local or global)." >&2
  echo "Run: git config --global user.name 'Your Name'" >&2
  exit 1
fi

if [[ -z "$email" && -z "$global_email" ]]; then
  echo "[pre-commit] ERROR: git user.email is not set (local or global)." >&2
  echo "Run: git config --global user.email 'your.email@example.com'" >&2
  exit 1
fi

exit 0
