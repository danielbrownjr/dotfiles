#!/bin/bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
STAMP="$(date '+%Y%m%d-%H%M%S')-$$"
append_block() {
  local file="$1" marker="$2" content="$3"
  if [[ -e "$file" ]] && /usr/bin/grep -Fq "$marker" "$file"; then return; fi
  if [[ -e "$file" ]]; then cp -p "$file" "$file.backup-$STAMP"; fi
  printf '\n%s\n' "$content" >> "$file"
  printf '\n- %s: Added %s block to %s; existing file backed up if present.\n' \
    "$(date '+%Y-%m-%d %H:%M:%S %Z')" "$marker" "$file" >> "$ROOT/setup-log.md"
}
append_block "$HOME/.zprofile" '# macbook-setup: Homebrew' '# macbook-setup: Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi'
append_block "$HOME/.zshrc" '# macbook-setup: shell basics' '# macbook-setup: shell basics
# Also support interactive shells that are not login shells.
if [[ -d /opt/homebrew/bin ]]; then
  typeset -U path fpath
  path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
  fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fi
autoload -Uz compinit
compinit
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS
# A leading space excludes a command from history; never type secrets as arguments.'
append_block "$HOME/.zshrc" '# macbook-setup: local commands' '# macbook-setup: local commands
typeset -U path
path=("$HOME/.local/bin" $path)'
append_block "$HOME/.zshrc" '# macbook-setup: default terminal editor' '# macbook-setup: default terminal editor
export EDITOR=vim
export VISUAL=vim'
append_block "$HOME/.zshrc" '# macbook-setup: fzf shell integration' '# macbook-setup: fzf shell integration
if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS='\''--height=40% --layout=reverse --border=rounded'\''
  source <(fzf --zsh)
fi'
mkdir -p "$HOME/.config/zsh"
if [[ -e "$HOME/.config/zsh/work.zsh" ]]; then
  cp -p "$HOME/.config/zsh/work.zsh" "$HOME/.config/zsh/work.zsh.backup-$STAMP"
fi
cp "$ROOT/config/work.zsh" "$HOME/.config/zsh/work.zsh"
append_block "$HOME/.zshrc" '# macbook-setup: project navigation' '# macbook-setup: project navigation
[[ -r "$HOME/.config/zsh/work.zsh" ]] && source "$HOME/.config/zsh/work.zsh"'
append_block "$HOME/.zshrc" '# macbook-setup: Rust' '# macbook-setup: Rust
[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"'
if [[ -e "$HOME/.config/zsh/terminal-tools.zsh" ]]; then
  cp -p "$HOME/.config/zsh/terminal-tools.zsh" "$HOME/.config/zsh/terminal-tools.zsh.backup-$STAMP"
fi
cp "$ROOT/config/terminal-tools.zsh" "$HOME/.config/zsh/terminal-tools.zsh"
append_block "$HOME/.zshrc" '# macbook-setup: terminal tools' '# macbook-setup: terminal tools
[[ -r "$HOME/.config/zsh/terminal-tools.zsh" ]] && source "$HOME/.config/zsh/terminal-tools.zsh"'
/bin/zsh -n "$HOME/.zprofile" "$HOME/.zshrc"
