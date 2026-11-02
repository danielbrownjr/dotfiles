#!/bin/bash
# Run in an interactive terminal: /bin/bash bootstrap.sh
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
LOG="$ROOT/setup-log.md"
note() { printf '\n- %s: %s\n' "$(date '+%Y-%m-%d %H:%M:%S %Z')" "$*" >> "$LOG"; }
if ! /usr/bin/xcode-select -p >/dev/null 2>&1; then
  printf 'Finish the Apple Command Line Tools installer, then rerun this script.\n'
  exit 1
fi
if [[ ! -x /opt/homebrew/bin/brew ]]; then
  installer="$(mktemp -t macbook-homebrew)"
  trap 'rm -f "$installer"' EXIT
  /usr/bin/curl --fail --location --proto '=https' --tlsv1.2 \
    https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o "$installer"
  /bin/bash "$installer"
  note 'Installed native Homebrew using the official installer.'
fi
export HOMEBREW_NO_ANALYTICS=1
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file="$ROOT/Brewfile"
note 'Installed or verified all packages declared in Brewfile.'
/bin/bash "$ROOT/configure-shell.sh"
/bin/bash "$ROOT/configure-appearance.sh"
/bin/bash "$ROOT/configure-vim.sh"
/bin/bash "$ROOT/configure-tmux.sh"
mkdir -p "$HOME/.local/bin"
if [[ -e "$HOME/.local/bin/pflash" ]]; then
  cp -p "$HOME/.local/bin/pflash" "$HOME/.local/bin/pflash.backup-$(date +%Y%m%d-%H%M%S)-$$"
fi
install -m 755 "$ROOT/bin/pflash" "$HOME/.local/bin/pflash"
git --version
for tool in gh rg fd fzf bat btop starship uv ffmpeg picotool vim tmux; do command -v "$tool"; done
/bin/zsh -lic 'whence -w compdef; print -r -- "History limit: $SAVEHIST"; command -v brew rg'
note 'Batch verification passed; Git available, package commands found, fresh zsh loaded.'
