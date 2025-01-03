#!/bin/bash

# Get the selected session using fzf-tmux
selected_session=$(sesh list -tc --icons | fzf-tmux -p 80%,70% \
    --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
    --header '  ^a all ^t tmux ^g configs ^d tmux kill ^f find' \
    --bind 'tab:down,btab:up' \
    --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
    --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
    --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
    --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
    --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list -tc --icons)' \
    --preview-window 'right:55%' \
    --preview 'sesh preview {}' \
)

# Check if a session was selected
if [[ -n "$selected_session" ]]; then
  # Connect to the selected session
  sesh connect "$selected_session"
else
  echo "No session selected."
fi
