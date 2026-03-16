#!/bin/sh
# sidebar-click.sh - Handle mouse click on sidebar to switch window/session
# Called by tmux binding: run-shell "~/.tmux-scripts/sidebar-click.sh #{mouse_y}"

mouse_y=$1
mouse_line=$((mouse_y + 1))

# Find sidebar pane
sidebar_id=$(tmux list-panes -a -F '#{pane_id}|#{pane_title}' | grep '|tmux-sidebar$' | head -1 | cut -d'|' -f1)
[ -z "$sidebar_id" ] && exit 0

# Capture sidebar content (plain text, no ANSI escape codes)
tmpfile=$(mktemp)
tmux capture-pane -t "$sidebar_id" -p > "$tmpfile" 2>/dev/null

# Walk lines to find session/window at clicked position
sess=""
widx=""
n=0

while IFS= read -r line; do
  n=$((n + 1))

  # Match patterns in specificity order (most specific first)
  case "$line" in
    "▶ "*)
      sess=$(printf '%s' "${line#▶ }" | sed 's/ *$//')
      widx=""
      ;;
    "       "*)
      # Pane line (7+ spaces) — keep parent window target
      ;;
    "    "[0-9]*)
      # Window line (4 spaces + digit)
      widx=$(printf '%s' "$line" | sed 's/^    \([0-9]*\):.*/\1/')
      ;;
    "  "?*)
      # Other session (2 spaces + text)
      sess=$(printf '%s' "${line#  }" | sed 's/ *$//')
      widx=""
      ;;
  esac

  [ "$n" -ge "$mouse_line" ] && break
done < "$tmpfile"

rm -f "$tmpfile"

# Switch to target
if [ -n "$sess" ] && [ -n "$widx" ]; then
  tmux switch-client -t "${sess}:${widx}" 2>/dev/null
elif [ -n "$sess" ]; then
  tmux switch-client -t "${sess}" 2>/dev/null
fi

exit 0
