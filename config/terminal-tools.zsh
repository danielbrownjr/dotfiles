# Lightweight directory tools and an on-demand shortcut reminder.
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi
if command -v eza >/dev/null 2>&1; then
  alias ll='eza -lh --git'
  alias la='eza -lah --git'
  alias lt='eza --tree --level=2'
fi
keys() {
  cat <<'KEYS'
TERMINAL CHEAT SHEET
  Ctrl + Space   Show/hide Ghostty quick terminal (global)
  Ctrl + R       Search command history; Enter inserts, Enter again runs
  Ctrl + T       Pick a file; inserts its path into the current command
  Esc, then C    Pick a directory and jump there
  Esc            Cancel a fuzzy picker
  Tab            Complete a command or path
  Ctrl + A / E   Beginning / end of command line (Emacs keymap)
  Ctrl + U / K   Delete back to beginning / forward to end (Emacs keymap)
  Ctrl + C       Cancel current command

NAVIGATION AND FILES
  work [text]    Pick a project directory
  work -e        Pick a project and open VS Code
  z rust         Jump to a previously visited matching directory
  zi             Fuzzy-pick a directory remembered by zoxide
  ll / la        Detailed listing / include hidden files
  lt             Directory tree, two levels deep
  keys           Show this reminder

TMUX (press Ctrl+B, release, then the next key)
  tmux new -As dev   Create or attach to your dev session
  | / -             Split side-by-side / top-and-bottom
  h j k l           Move between panes
  c / n / p         New / next / previous window
  z                 Toggle pane zoom
  d                 Detach, keeping programs running
  [                 Scroll/copy mode; q exits
  ?                 All key bindings
  tmux attach -t dev   Return after detaching

VIM (Normal mode; jk or kj exits Insert mode)
  -ev / -sv      Edit / reload vimrc
  -w             Save file
KEYS
}
