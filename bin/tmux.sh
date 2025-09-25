#!/bin/bash

tmux-check() {
     if [[ -z "$TMUX" ]]; then
        echo "Not running in tmux session"
        return 1
    fi
}

tmux-session() {
    tmux-check || return 1
    local session_count=$(tmux list-sessions 2>/dev/null | wc -l)
    if [[ $session_count -eq 0 ]]; then
        echo "No tmux sessions active"
        return 1
    fi
    
    local session=$(tmux list-sessions -F "#{session_name}: #{session_windows} windows (#{session_attached} attached)" 2>/dev/null | \
        fzf --tmux 80%,60% --prompt="Tmux Session> " \
            --bind='enter:accept' \
            --bind='ctrl-d:execute-silent(
                session_name=$(echo {} | cut -d: -f1)
                tmux kill-session -t "$session_name"
            )+reload(tmux list-sessions -F "#{session_name}: #{session_windows} windows (#{session_attached} attached)" 2>/dev/null)' \
            --bind='ctrl-x:execute-silent(
                session_name=$(echo {} | cut -d: -f1)
                tmux kill-session -t "$session_name"
            )+reload(tmux list-sessions -F "#{session_name}: #{session_windows} windows (#{session_attached} attached)" 2>/dev/null)' \
            --header='Enter: switch | Ctrl-D/Ctrl-X: delete session')
    
    if [[ -n "$session" ]]; then
        local session_name=$(echo "$session" | cut -d: -f1)
        tmux switch-client -c "$TMUX_PANE" -t "$session_name"
        echo "Switched to session: $session_name"
    fi
}

