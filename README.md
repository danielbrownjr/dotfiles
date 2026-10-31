# Daniel's dotfiles

Lean Apple Silicon workstation configuration. Reviewed 2026-10-31.
Nothing here contains private keys, authentication tokens, or shell history.
Mac configuration lives on `main`. The previous Linux dotfiles are preserved on
`legacy-before-macos-2026-10-31` (and the original `master`).

## Restore on another Mac

Read `Brewfile` and the scripts before running them. The full bootstrap installs
software and applies the terminal configuration; run it only when those changes
are wanted. Apple Command Line Tools must already be installed. Homebrew's
official installer may request local administrator authentication.

```sh
git clone https://github.com/danielbrownjr/dotfiles.git ~/Documents/Projects/dotfiles
cd ~/Documents/Projects/dotfiles
bash bootstrap.sh
```

This installs Brewfile packages, configures zsh, Ghostty, Starship and Vim,
and installs `pflash` in `~/.local/bin`. It does not flash a board. Existing
configuration files are backed up beside the originals before replacement or
append operations. Restart Ghostty after restoring its configuration.

Individual stages can also be run with `bash configure-shell.sh`,
`bash configure-appearance.sh`, or `bash configure-vim.sh`.
Shell blocks are appended only when their marker is absent. The appearance
script preserves a Ghostty config already marked as configured; compare it with
`config/ghostty.conf` manually when updating an existing machine. Starship and
Vim templates replace their live files after backup.

## Configuration sources

| Source | Installed location |
| --- | --- |
| `configure-shell.sh` | `~/.zprofile`, `~/.zshrc` |
| `config/ghostty.conf` | `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty` |
| `config/starship.toml` | `~/.config/starship.toml` |
| `config/vimrc` | `~/.vimrc` |
| `config/vim-statusline.vim` | `~/.vim/statusline.vim` |
| `bin/pflash` | `~/.local/bin/pflash` |

Ghostty uses Fira Mono, Catppuccin Mocha, and Control-Space for a centered quick
terminal at 650 pixels wide and 45% screen height. It starts without a regular
terminal window. Grant the global shortcut permission locally if macOS requests
it, and check that Control-Space is not assigned to input-source switching.

zsh uses Starship, 10,000 history entries, fzf shortcuts and Vim as EDITOR/VISUAL.
Vim uses rapid `jk`/`kj` to exit Insert mode; Escape and arrows are disabled.
Dash is the leader: `-ev` edits vimrc, `-sv` reloads it, `-w` saves.

## Manual steps and deliberately separate work

- Install/sign into 1Password, ChatGPT/Codex, Spotify and WhatsApp from official
  sources as needed. Maccy was installed separately; restore its clipboard
  shortcut as Command-Shift-V and enable launch at login if wanted.
- Sign into GitHub CLI with `gh auth login`. Restore Git identity separately.
- Generate a new passphrase-protected SSH key on a replacement machine; authorize
  its public key on the servers and GitHub. Never put the private key in Git.
- Recreate your SSH host aliases locally. Hostnames, addresses and private keys
  are intentionally omitted from this public repository.
- Run `bash configure-remote-editor.sh` if VS Code Remote SSH and Codex are
  wanted. Authenticate locally. Remote extension installation is separate.
  The old remote Codex timeout workaround is not part of this bootstrap.
- macOS preferences are manual: dark mode, Dock auto-hide, Finder file extensions,
  path/status bars, Spotlight Command-D, firewall enabled. Verify each in Settings.
- Spotify's background startup helper is disabled in General > Login Items &
  Extensions. Maccy and 1Password remain enabled.
- Full-machine backups are separate. This repo is not a backup of documents or
  credentials, and contains no NAS deployment configuration.
- See `PICO-FLASHING.md` for board flashing. Old fstab noauto rules did not work
  reliably on this Mac; bootstrap deliberately does not apply them.

## Scope of the package list

The Brewfile includes current top-level Homebrew tools and casks, plus Ghostty
for rebuilding its manually installed app. Dependencies are resolved by Homebrew.
Versions are not pinned, so a future restore installs available versions rather
than an exact binary snapshot. No Homebrew services are enabled by these scripts.

## Keeping this safe to version

`.gitignore` excludes local preference backups, screenshots, common key files,
dotenv files, histories and the generated setup log. It is a guardrail, not a
secret scanner. Review changes before committing. Credentials, SSH configuration,
NAS deployment details and machine audit logs are intentionally kept local.
