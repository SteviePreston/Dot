#!/bin/bash

tmux-check() {
     if [[ -z "$TMUX" ]]; then
        echo "Not running in tmux session"
        return 1
    fi
}

git-check() {
        if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Not in a git repository"
        return 1
    fi
}


