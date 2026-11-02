#!/bin/bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
if [[ -e "$HOME/.tmux.conf" ]]; then
  cp -p "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup-$(date +%Y%m%d-%H%M%S)-$$"
fi
cp "$ROOT/config/tmux.conf" "$HOME/.tmux.conf"
