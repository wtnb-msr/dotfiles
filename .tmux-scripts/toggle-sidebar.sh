#!/bin/sh
# Toggle tmux sidebar pane in the current window

# Find sidebar pane by its title
sidebar_id=$(tmux list-panes -F '#{pane_id}|#{pane_title}' | grep '|tmux-sidebar$' | head -1 | cut -d'|' -f1)

if [ -n "$sidebar_id" ]; then
  tmux kill-pane -t "$sidebar_id"
  # Mark as explicitly closed (prevent auto-reopen)
  tmux set -w @sidebar_disabled 1
else
  # Clear disabled flag and create sidebar
  tmux set -wu @sidebar_disabled
  tmux split-window -hbd -l 30 "$HOME/.tmux-scripts/sidebar.sh"
fi
