#!/bin/bash

history-exec() {
    tmux-check    
    local temp_history=$(mktemp)
    local temp_selection=$(mktemp)
    
    fc -l 1 | awk '{$1=""; print substr($0,2)}' | tail -r > "$temp_history"
    
    tmux display-popup -d '#{pane_current_path}' -w80% -h60% -E "
        cat '$temp_history' | \
        fzf --height=100% \
            --reverse \
            --border=rounded \
            --prompt='History> ' \
            --no-preview \
            --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 \
            --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
            --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 > '$temp_selection'
    "
    
    local cmd=$(cat "$temp_selection" 2>/dev/null)
    
    rm "$temp_history" "$temp_selection"
    if [[ -n "$cmd" ]]; then
        eval "$cmd"
    fi
}
    
project-nav() {
    tmux-check    
    local base_dir=${1:-~/Developer}
    local temp_selection=$(mktemp)
    
    tmux display-popup -d '#{pane_current_path}' -w85% -h70% -E "
        find '$base_dir' -mindepth 1 -maxdepth 1 -type d 2>/dev/null | \
        sed 's|$HOME|~|g' | \
        fzf --height=100% --reverse --border=rounded --prompt='Projects> ' \
            --no-preview \
            --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 \
            --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
            --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 > '$temp_selection'
    "
    
    local dir=$(cat "$temp_selection" 2>/dev/null)
    rm "$temp_selection"
    
    if [[ -n "$dir" ]]; then
        local full_dir=$(echo "$dir" | sed "s|~|$HOME|g")
        cd "$full_dir"
    fi
}

project-root() {
    local root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
    cd "$root"
}

