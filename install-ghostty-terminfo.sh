#!/bin/bash
# Install Ghostty's bundled terminal description in a remote user's account.
set -euo pipefail
host="${1:-heph}"
if /usr/bin/ssh -o BatchMode=yes -o ConnectTimeout=8 "$host" \
  'infocmp -x xterm-ghostty >/dev/null 2>&1'; then
  printf 'Ghostty terminfo is already available on %s.\n' "$host"
  exit 0
fi
/usr/bin/infocmp -A /Applications/Ghostty.app/Contents/Resources/terminfo -x xterm-ghostty |
  /usr/bin/ssh "$host" 'mkdir -p "$HOME/.terminfo"; tic -x -o "$HOME/.terminfo" - && infocmp -x xterm-ghostty >/dev/null'
