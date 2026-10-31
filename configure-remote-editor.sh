#!/bin/bash
# Install the approved remote editor extension after VS Code is installed.
set -euo pipefail
CODE='/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code'
if [[ ! -x "$CODE" ]]; then
  printf 'Install the visual-studio-code Homebrew cask first.\n' >&2
  exit 1
fi
"$CODE" --install-extension ms-vscode-remote.remote-ssh
"$CODE" --install-extension openai.chatgpt
"$CODE" --list-extensions --show-versions
# Connect interactively; SSH key passphrase entry stays local.
printf '\nConnect using: code --remote ssh-remote+heph\n'
