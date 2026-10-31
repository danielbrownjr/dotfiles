#!/bin/bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
STAMP="$(date '+%Y%m%d-%H%M%S')-$$"
ghostty="$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
mkdir -p "$(dirname "$ghostty")" "$HOME/.config"
# Back up each existing config before making changes.
for file in "$ghostty" "$HOME/.config/starship.toml" "$HOME/.zshrc"; do
  if [[ -e "$file" ]]; then cp -p "$file" "$file.backup-$STAMP"; fi
done
if ! grep -Fq '# macbook-setup: appearance' "$ghostty"; then
  printf '\n# macbook-setup: appearance\n' >> "$ghostty"
  cat "$ROOT/config/ghostty.conf" >> "$ghostty"
fi
cp "$ROOT/config/starship.toml" "$HOME/.config/starship.toml"
if ! grep -Fq '# macbook-setup: Starship' "$HOME/.zshrc"; then
  cat >> "$HOME/.zshrc" <<'EOF'

# macbook-setup: Starship
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
EOF
fi
/Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config
/bin/zsh -n "$HOME/.zshrc"
printf '\n- %s: Approved appearance batch. Backed up Ghostty, zsh and any existing Starship config with suffix .backup-%s. Applied bundled Catppuccin Mocha, 13-point font, 12x10-point padding and opaque background. Installed minimal Starship config with directory, Git branch, long-command duration and success/error indicator. Ghostty and zsh config validation passed.\n' "$(date '+%Y-%m-%d %H:%M:%S %Z')" "$STAMP" >> "$ROOT/setup-log.md"
