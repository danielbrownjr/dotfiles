# Project navigation: immediate children only, no recursive indexing.
work() {
  emulate -L zsh
  local editor=false
  if [[ "${1:-}" == -e ]]; then editor=true; shift; fi
  if (( $# > 1 )) || [[ "${1:-}" == -* ]]; then
    print -r -- 'Usage: work [-e] [search text]'
    return 2
  fi
  local root="${WORK_ROOT:-$HOME/Documents/Projects}"
  [[ -d "$root" ]] || { print -u2 -r -- "Project directory missing: $root"; return 1; }
  (( $+commands[fzf] )) || { print -u2 -- 'fzf is required.'; return 1; }
  local code='/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code'
  if $editor && [[ ! -x "$code" ]]; then
    print -u2 -- 'VS Code command is unavailable.'; return 1
  fi
  local -a dirs
  dirs=("$root"/*(/N))
  (( ${#dirs} )) || { print -u2 -- 'No projects found.'; return 1; }
  local selected
  selected=$(printf '%s\0' "${dirs[@]:t}" | fzf --read0 --print0 --no-multi \
    --prompt='Project > ' --query="${1:-}") || return
  [[ -n "$selected" ]] || return 1
  builtin cd -- "$root/$selected" || return
  if $editor; then "$code" .; fi
}
