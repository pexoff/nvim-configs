#!/usr/bin/env bash
# nvim-configs: sets up a device
#
# Usage:  ./install.sh client
#         ./install.sh server
#
# Or without cloning first:
#   curl -fsSL https://raw.githubusercontent.com/pexoff/nvim-configs/main/install.sh | bash -s -- client

set -euo pipefail

REPO_URL="${NVIM_CONFIGS_REPO:-https://github.com/pexoff/nvim-configs.git}"
TARGET="${NVIM_CONFIGS_DIR:-$HOME/.local/share/nvim-configs}"
CONFIG_LINK="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

PROFILE="${1:-}"

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m==>\033[0m %s\n' "$*"; }
fail() { printf '\033[1;31m==>\033[0m %s\n' "$*" >&2; exit 1; }

# 1. Check profile
if [[ "$PROFILE" != "client" && "$PROFILE" != "server" ]]; then
  fail "Please specify a profile: ./install.sh client  or  ./install.sh server"
fi

# 2. Check requirements
command -v git >/dev/null || fail "git is not installed."
command -v nvim >/dev/null || warn "nvim is not installed. Setting up the config anyway."

# 3. Clone or update repo
if [[ -d "$TARGET/.git" ]]; then
  info "Repo already exists in $TARGET – pulling updates"
  git -C "$TARGET" pull --ff-only || warn "Update failed (local changes?). Continuing with the current state."
else
  info "Cloning $REPO_URL to $TARGET"
  mkdir -p "$(dirname "$TARGET")"
  git clone "$REPO_URL" "$TARGET"
fi

[[ -d "$TARGET/$PROFILE" ]] || fail "Profile folder $TARGET/$PROFILE does not exist."

# 4. Back up existing config
if [[ -L "$CONFIG_LINK" ]]; then
  info "Replacing existing symlink $CONFIG_LINK"
  rm "$CONFIG_LINK"
elif [[ -e "$CONFIG_LINK" ]]; then
  BACKUP="$CONFIG_LINK.backup-$(date +%Y%m%d-%H%M%S)"
  warn "Backing up existing config to $BACKUP"
  mv "$CONFIG_LINK" "$BACKUP"
fi

# 5. Create symlink
mkdir -p "$(dirname "$CONFIG_LINK")"
ln -s "$TARGET/$PROFILE" "$CONFIG_LINK"
info "$CONFIG_LINK -> $TARGET/$PROFILE"

# 6. Hint about old packer plugins
PACKER_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/packer"
if [[ -d "$PACKER_DIR" ]]; then
  warn "Found old packer plugins: $PACKER_DIR"
  warn "They are no longer needed. Remove with:  rm -rf \"$PACKER_DIR\""
fi

info "Done! Start nvim – lazy.nvim installs all plugins on first launch."
