#!/bin/bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
if [[ -e "$HOME/.vimrc" ]]; then
  cp -p "$HOME/.vimrc" "$HOME/.vimrc.backup-$(date +%Y%m%d-%H%M%S)"
fi
cp "$ROOT/config/vimrc" "$HOME/.vimrc"
mkdir -p "$HOME/.vim"
if [[ -e "$HOME/.vim/statusline.vim" ]]; then
  cp -p "$HOME/.vim/statusline.vim" "$HOME/.vim/statusline.vim.backup-$(date +%Y%m%d-%H%M%S)"
fi
cp "$ROOT/config/vim-statusline.vim" "$HOME/.vim/statusline.vim"
printf '\n- %s: Applied approved lean Vim config; existing ~/.vimrc backed up if present. Rapid jk/kj Insert exits, physical Escape and arrows disabled in normal/visual/operator/Insert/command-line modes. Ctrl-C remains an Insert exit. Built-in habamax theme, relative line numbers, filetype indentation, smart-case search, 4-space defaults; no plugins/services.\n' "$(date '+%Y-%m-%d %H:%M:%S %Z')" >> "$ROOT/setup-log.md"
