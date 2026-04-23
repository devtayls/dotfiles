#!/bin/bash
# Shared helpers for dots-test, dots-restore, dots-status.
# Source this file; do not execute it directly.

DOTS_MAIN="${HOME}/dotfiles"
DOTS_WORKTREES="${HOME}/dotfiles__worktrees"
DOTS_STATE_DIR="${HOME}/.local/state/dots"
DOTS_ACTIVE_FILE="${DOTS_STATE_DIR}/active"
DOTS_BACKUP_DIR="${DOTS_STATE_DIR}/backups"

# Directories the stow packages actually install into. Scope for snapshots and
# the orphan sweep — keeps us out of ~/Library and other large trees.
DOTS_TARGET_DIRS=(
  "$HOME"
  "$HOME/.config"
  "$HOME/.local/bin"
  "$HOME/.local/lib"
)

dots_ensure_state_dirs() {
  mkdir -p "$DOTS_BACKUP_DIR"
}

# Echo the currently-active source directory. Defaults to $DOTS_MAIN when
# no state file exists (or it's empty).
dots_current_source() {
  if [[ -f "$DOTS_ACTIVE_FILE" ]]; then
    local src
    src="$(cat "$DOTS_ACTIVE_FILE")"
    if [[ -n "$src" ]]; then
      echo "$src"
      return
    fi
  fi
  echo "$DOTS_MAIN"
}

# Resolve a user-supplied argument to an absolute source path.
#   (no arg)      -> $PWD
#   <path>        -> absolute form of that path
#   <bare name>   -> $DOTS_WORKTREES/<name>
# Validates the candidate looks like a dotfiles source.
dots_resolve_target() {
  local arg="${1:-}"
  local candidate

  if [[ -z "$arg" ]]; then
    candidate="$PWD"
  elif [[ -d "$arg" ]]; then
    candidate="$(cd "$arg" && pwd)"
  elif [[ -d "${DOTS_WORKTREES}/${arg}" ]]; then
    candidate="${DOTS_WORKTREES}/${arg}"
  else
    echo "dots: cannot resolve '$arg' to a worktree or path" >&2
    return 1
  fi

  if [[ ! -d "${candidate}/dots" && ! -d "${candidate}/neovim" && ! -d "${candidate}/zsh" ]]; then
    echo "dots: '${candidate}' does not look like a dotfiles source" >&2
    return 1
  fi

  echo "$candidate"
}

# Write a TSV snapshot (link<TAB>target) of every dotfiles-owned symlink
# under $DOTS_TARGET_DIRS to stdout.
dots_snapshot() {
  local d link tgt
  for d in "${DOTS_TARGET_DIRS[@]}"; do
    [[ -d "$d" ]] || continue
    while IFS= read -r link; do
      tgt="$(readlink "$link")"
      if [[ "$tgt" == *dotfiles* ]]; then
        printf '%s\t%s\n' "$link" "$tgt"
      fi
    done < <(find "$d" -maxdepth 4 -type l 2>/dev/null)
  done
}

# Save a snapshot to a timestamped file; echo the path.
dots_save_backup() {
  dots_ensure_state_dirs
  local ts path
  ts="$(date +%Y%m%d-%H%M%S)"
  path="${DOTS_BACKUP_DIR}/${ts}.txt"
  dots_snapshot > "$path"
  echo "$path"
}

# `stow -D` every top-level package in src. Tolerates a missing src dir.
dots_unstow() {
  local src="$1"
  if [[ ! -d "$src" ]]; then
    echo "  (source missing; skipping unstow: $src)"
    return 0
  fi
  (cd "$src" && stow --no-folding -t "$HOME" -D */)
}

# `stow` every top-level package in src.
dots_stow() {
  local src="$1"
  (cd "$src" && stow --no-folding -t "$HOME" */)
}

# Remove dotfiles-owned symlinks whose targets no longer exist.
# Policy: ownership = readlink contains "dotfiles"; action = rm only when
# the link is broken (target resolution fails).
sweep_orphans() {
  local removed=0
  local d link tgt
  for d in "${DOTS_TARGET_DIRS[@]}"; do
    [[ -d "$d" ]] || continue
    while IFS= read -r link; do
      [[ -L "$link" ]] || continue
      tgt="$(readlink "$link")"
      [[ "$tgt" == *dotfiles* ]] || continue
      if [[ ! -e "$link" ]]; then
        echo "  sweeping orphan: $link -> $tgt"
        rm "$link"
        removed=$((removed + 1))
      fi
    done < <(find "$d" -maxdepth 4 -type l 2>/dev/null)
  done
  if (( removed > 0 )); then
    echo "  swept $removed orphan symlink(s)"
  fi
}

dots_set_active() {
  dots_ensure_state_dirs
  echo "$1" > "$DOTS_ACTIVE_FILE"
}

dots_clear_active() {
  rm -f "$DOTS_ACTIVE_FILE"
}

dots_print_status() {
  local src branch backups
  src="$(dots_current_source)"
  if [[ "$src" == "$DOTS_MAIN" ]]; then
    echo "active source: main ($src)"
  else
    echo "active source: $src"
    if [[ -e "$src/.git" ]]; then
      branch="$(git -C "$src" rev-parse --abbrev-ref HEAD 2>/dev/null || echo '?')"
      echo "branch:        $branch"
    fi
  fi
  backups=$(find "$DOTS_BACKUP_DIR" -maxdepth 1 -type f -name '*.txt' 2>/dev/null | wc -l | tr -d ' ')
  echo "backups:       $backups (in $DOTS_BACKUP_DIR)"
}
