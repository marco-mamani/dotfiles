#!/usr/bin/env bash
# Fuzzy-pick an existing note with fzf.
NOTES_DIR="${NOTES_DIR:-$HOME/notes}"
mkdir -p "$NOTES_DIR"

# Fallback if fzf is missing: open the folder in Neovim
if ! command -v fzf >/dev/null 2>&1; then
  exec nvim "$NOTES_DIR/"
fi

name="$(ls -1 "$NOTES_DIR" 2>/dev/null | sed 's/\.md$//' \
  | fzf --prompt='note > ' --border=rounded)" || exit 0

[ -n "$name" ] || exit 0
exec nvim "$NOTES_DIR/$name.md"
