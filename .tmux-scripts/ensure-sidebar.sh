#!/bin/sh
# Ensure sidebar exists in the current window (unless explicitly disabled)

SIDEBAR_WIDTH=35

# Skip if sidebar was explicitly closed in this window
disabled=$(tmux display-message -p '#{@sidebar_disabled}' 2>/dev/null)
[ "$disabled" = "1" ] && exit 0

# Skip if sidebar already exists in this window
sidebar_id=$(tmux list-panes -F '#{pane_id}|#{pane_title}' 2>/dev/null | grep '|tmux-sidebar$' | head -1 | cut -d'|' -f1)
if [ -n "$sidebar_id" ]; then
  # Resize to fixed width in case terminal was resized
  tmux resize-pane -t "$sidebar_id" -x "$SIDEBAR_WIDTH" 2>/dev/null
  exit 0
fi

# Prevent race condition: use lock file
lockfile="/tmp/tmux-sidebar-$(tmux display-message -p '#S-#I').lock"
if [ -f "$lockfile" ]; then
  # Lock exists and is recent (< 3 seconds)
  lock_age=$(( $(date +%s) - $(stat -f %m "$lockfile" 2>/dev/null || echo 0) ))
  [ "$lock_age" -lt 3 ] && exit 0
fi
touch "$lockfile"

# Create sidebar
tmux split-window -hbd -l "$SIDEBAR_WIDTH" "$HOME/.tmux-scripts/sidebar.sh"

# Cleanup lock after a moment
(sleep 2 && rm -f "$lockfile") &
