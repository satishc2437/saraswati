#!/usr/bin/env bash
set -euo pipefail

echo "[git-identity] Initializing git identity inside Dev Container..."

HOST_CFG="/home/vscode/.host.gitconfig"
LOCAL_CFG="/home/vscode/.gitconfig"
REPO_CFG="/workspaces/saraswati/.git/config"

have_local_name=$(git config --global user.name || true)
have_local_email=$(git config --global user.email || true)
DEFAULT_NAME="Saraswati Developer"
DEFAULT_EMAIL="dev@example.invalid"

if [[ -z "$have_local_name" || -z "$have_local_email" ]]; then
  if [[ -f "$HOST_CFG" ]]; then
    echo "[git-identity] Found host gitconfig at $HOST_CFG; attempting to read name/email"
    host_name=$(grep -E '^\s*name\s*=' "$HOST_CFG" | head -n1 | cut -d'=' -f2 | sed 's/^ *//') || true
    host_email=$(grep -E '^\s*email\s*=' "$HOST_CFG" | head -n1 | cut -d'=' -f2 | sed 's/^ *//') || true
    if [[ -n "$host_name" && -n "$host_email" ]]; then
      git config --global user.name "$host_name"
      git config --global user.email "$host_email"
      echo "[git-identity] Applied host identity: $host_name <$host_email>"
    else
      echo "[git-identity] Host config present but missing name/email; falling back to defaults." >&2
      git config --global user.name "${DEFAULT_NAME}"
      git config --global user.email "${DEFAULT_EMAIL}"
    fi
  else
    echo "[git-identity] No host gitconfig detected; setting placeholder identity. Override with: git config --global user.name 'Your Name' && git config --global user.email you@example.com" >&2
    git config --global user.name "${DEFAULT_NAME}"
    git config --global user.email "${DEFAULT_EMAIL}"
  fi
fi

# Include host gitconfig if mounted and not already included
# (Optional) If host config mounted, user can manually add include with:
#   git config --global include.path "$HOST_CFG"

# Ensure commit template for multi-developer consistency
COMMIT_TEMPLATE="/workspaces/saraswati/.git-commit-template.txt"
if [[ ! -f "$COMMIT_TEMPLATE" ]]; then
  cat > "$COMMIT_TEMPLATE" <<'EOF'
# Commit Title (imperative, 50 chars max)
#
# Body (wrap at 72 chars). Explain WHAT and WHY, avoid HOW.
#
# Reference: link issues like: Closes #123 or Related #456
#
# Footer examples:
# BREAKING CHANGE: describe impact
# Co-authored-by: Name <email@example.com>
EOF
  git config commit.template "$COMMIT_TEMPLATE" || true
fi

echo "[git-identity] Current git identity:" $(git config --global user.name || echo "(none)") "<"$(git config --global user.email || echo "(none)")">"
echo "[git-identity] To change identity run: git config --global user.name 'Your Name'; git config --global user.email your@example.com"

echo "[git-identity] Setup complete."
