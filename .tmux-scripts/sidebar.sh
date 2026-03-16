#!/bin/sh
# tmux-sidebar - Display tmux session/window/pane tree

# Set pane title for identification by toggle script
printf '\033]2;tmux-sidebar\033\\'

# Hide cursor (sidebar is non-interactive)
printf '\033[?25l'

# Temp file for buffered rendering (eliminates flicker)
tmpfile=$(mktemp)
trap 'printf "\033[?25h"; rm -f "$tmpfile"' EXIT INT TERM

# Detect Claude Code agent state from pane content
claude_state() {
  content=$(tmux capture-pane -t "$1" -p 2>/dev/null)

  # Wait: permission/approval prompt (search entire screen, not just bottom)
  if printf '%s' "$content" | grep -qE 'Do you want to proceed|Esc to cancel'; then
    echo 'wait'
    return
  fi

  # Busy: tool running — match "⎿  Running…" to avoid false positives
  # from "Running…" appearing in response text
  if printf '%s' "$content" | grep -qF '⎿  Running…'; then
    echo 'busy'
    return
  fi

  # Busy: thinking/streaming response
  if printf '%s' "$content" | grep -qiE 'Thinking|Concocting|Sautéed'; then
    echo 'busy'
    return
  fi

  # Default: idle (input prompt visible)
  echo 'idle'
}

# Initial clear
clear

while true; do
  cur_sess=$(tmux display-message -p '#S' 2>/dev/null)
  cols=$(tput cols 2>/dev/null || echo 30)

  # Render entire frame to buffer
  {
    printf '\033[H'

    printf '\033[1mtmux\033[0m\033[K\n'
    printf '─%.0s' $(seq 1 "$cols")
    printf '\033[K\n'

    tmux list-sessions -F '#{session_name}' 2>/dev/null | sort | while read -r sess; do
      # Only show sessions that have at least one claude pane
      tmux list-panes -s -t "$sess" -F '#{pane_current_command}' 2>/dev/null | grep -q '^claude$' || continue

      if [ "$sess" = "$cur_sess" ]; then
        printf '\033[1;32m▶%s\033[0m\033[K\n' "$sess"
      else
        printf ' \033[2m%s\033[0m\033[K\n' "$sess"
      fi

      tmux list-windows -t "$sess" -F '#{window_index}|#{window_name}|#{window_active}' 2>/dev/null | \
      while IFS='|' read -r widx wname wactive; do
        # Only show windows that have at least one claude pane
        tmux list-panes -t "${sess}:${widx}" -F '#{pane_current_command}' 2>/dev/null | grep -q '^claude$' || continue

        if [ "$sess" = "$cur_sess" ] && [ "$wactive" = "1" ]; then
          printf '  \033[1;33m%s:%s *\033[0m\033[K\n' "$widx" "$wname"
        else
          printf '  %s:%s\033[K\n' "$widx" "$wname"
        fi

        tmux list-panes -t "${sess}:${widx}" -F '#{pane_index}|#{pane_current_command}|#{pane_active}|#{pane_title}|#{pane_id}' 2>/dev/null | \
        while IFS='|' read -r pidx pcmd pactive ptitle pid; do
          [ "$ptitle" = "tmux-sidebar" ] && continue

          is_active=0
          [ "$sess" = "$cur_sess" ] && [ "$wactive" = "1" ] && [ "$pactive" = "1" ] && is_active=1

          if [ "$pcmd" = "claude" ]; then
            state=$(claude_state "$pid")
            case "$state" in
              busy) state_tag='\033[33m busy\033[0m' ;;
              wait) state_tag='\033[35m wait\033[0m' ;;
              *)    state_tag='\033[32m idle\033[0m' ;;
            esac
            pdir=$(tmux display-message -t "$pid" -p '#{pane_current_path}' 2>/dev/null)
            plabel=$(basename "$pdir" 2>/dev/null || echo 'claude')

            if [ "$is_active" = "1" ]; then
              printf '    \033[1;36m·\033[0m %s%b ◀\033[K\n' "$plabel" "$state_tag"
            else
              printf '    · %s%b\033[K\n' "$plabel" "$state_tag"
            fi
          else
            if [ "$is_active" = "1" ]; then
              printf '    \033[1;36m· %s ◀\033[0m\033[K\n' "$pcmd"
            else
              printf '    \033[2m· %s\033[0m\033[K\n' "$pcmd"
            fi
          fi
        done
      done
    done

    printf '\033[2mC-t T: close\033[0m\033[K\n'
    printf '\033[J'
  } > "$tmpfile"

  # Single atomic write to terminal
  cat "$tmpfile"

  sleep 0.5
done
