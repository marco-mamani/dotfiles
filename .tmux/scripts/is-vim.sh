#!/usr/bin/env bash

# Return success if the current pane is running Vim/Neovim/fzf-like program.
pane_tty="${1:-}"
[ -n "$pane_tty" ] || exit 1

ps -o state= -o comm= -t "$pane_tty" 2>/dev/null |
  grep -iqE '^[^TXZ ]+ +([^[:space:]]+/)?g?(view|l?n?vim?x?|fzf)(diff)?$'
