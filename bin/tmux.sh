#!/bin/bash

fzf-window() {
    local width=${1:-80%}
    local height=${2:-70%}
    shift 2
    
    if [[ -n "$TMUX" ]]; then
        tmux display-popup -d '#{pane_current_path}' -w"$width" -h"$height" -E "$*"
    else
        echo "Not running in tmux session"
        return 1
    fi
}

tmux-session() {
    tmux-check
    local session_count=$(tmux list-sessions 2>/dev/null | wc -l)
    if [[ $session_count -eq 0 ]]; then
        echo "No tmux sessions active"
        return 1
    fi

    local session=$(tmux display-popup -d '#{pane_current_path}' -w80% -h60% -E '
        tmux list-sessions -F "#{session_name}: #{session_windows} windows (#{session_attached} attached)" 2>/dev/null | \
        fzf --height=100% --reverse --border=rounded --prompt="Tmux Session> " \
            --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 \
            --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
            --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6
    ')
    
    if [[ -n "$session" ]]; then
        local session_name=$(echo "$session" | cut -d: -f1)
        tmux switch-client -t "$session_name"
        echo "Switched to session: $session_name"
    fi
}

