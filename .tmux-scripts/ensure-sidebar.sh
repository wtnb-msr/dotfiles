#!/bin/sh
# Ensure sidebar exists in the current window (unless explicitly disabled)

# Skip if sidebar was explicitly closed in this window
disabled=$(tmux display-message -p '#{@sidebar_disabled}' 2>/dev/null)
[ "$disabled" = "1" ] && exit 0

# Skip if sidebar already exists in this window
tmux list-panes -F '#{pane_title}' 2>/dev/null | grep -q '^tmux-sidebar$' && exit 0

# Create sidebar
tmux split-window -hbd -l 30 "$HOME/.tmux-scripts/sidebar.sh"
