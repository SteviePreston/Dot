#!/bin/bash

project-nav-func() {
    project-nav
    zle reset-prompt
}

history-exec-func() {
    history-exec
    zle reset-prompt
}

tmux-session-func() {
    tmux-session
    zle reset-prompt
}

# Register widget
zle -N project-nav-func
zle -N history-exec-func
zle -N tmux-session-func
