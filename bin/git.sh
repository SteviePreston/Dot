#!/bin/bash

DEFAULT_BRANCH="main"

git-check() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Not in a git repository"
        return 1
    fi
}

get-default-branch() {
    local branch
    branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
    if [[ -z "$branch" ]]; then
        for candidate in "$DEFAULT_BRANCH" "main" "master" "develop"; do
            if git rev-parse --verify "$candidate" >/dev/null 2>&1; then
                branch="$candidate"
                break
            fi
        done
    fi
    echo "${branch:-main}"
}

git-log() {
    git-check || return 1
    tmux-check || return 1
    local default_branch=$(get-default-branch)
    
    git log --color=always --pretty=format:'%C(yellow)%h %C(blue)%ad %C(reset)%s %C(green)(%an)' --date=short "$default_branch" | \
    fzf --tmux 90%,70% --ansi --prompt="Git Log ($default_branch): " \
        --bind='enter:execute(
            commit=$(echo {} | awk "{print \$1}")
            git show --color=always "$commit" | less -R
        )+abort'
}

git-diff() {
   git-check || return 1
   tmux-check || return 1
   
   git diff --name-only | \
   fzf --tmux 90%,90% --preview='git diff --color=always -- {}' \
       --preview-window=down:70%
}

git-checkout() {
    git-check || return 1
    tmux-check || return 1
    
    local branch=$(git branch -a | grep -v HEAD | sed 's/^..//' | sed 's/remotes\/origin\///' | sort -u | \
    fzf --tmux 70%,60% --prompt='Git Checkout: ')
    
    if [[ -n "$branch" ]]; then
        branch=$(echo "$branch" | xargs)
        if git rev-parse --verify "$branch" >/dev/null 2>&1; then
            echo "Checking out branch: $branch"
            git checkout "$branch"
        else
            echo "Creating branch: $branch"
            git checkout -b "$branch"
        fi
    fi
}

git-tag-checkout() {
    git-check || return 1
    tmux-check || return 1
    
    local tag_count=$(git tag -l | wc -l)
    if [[ $tag_count -eq 0 ]]; then
        echo "No tags found in repository"
        return 1
    fi
    
    local tag=$(git tag -l --sort=-version:refname | \
        fzf --tmux 80%,70% --prompt='Git Tag Checkout: ' \
            --preview='
                tag=$(echo {} | xargs)
                echo "Tag: $tag"
                echo "---"
                git show --color=always --stat "$tag" 2>/dev/null | head -20
                echo
                echo "Tag info:"
                git tag -n5 "$tag" 2>/dev/null
            ' \
            --preview-window=right:60% \
            --bind='ctrl-d:preview-page-down,ctrl-u:preview-page-up')
    
    if [[ -n "$tag" ]]; then
        tag=$(echo "$tag" | xargs)
        echo "Checking out tag: $tag"
        git checkout "$tag"
    fi
}

git-status() {
    git-check || return 1
    tmux-check || return 1
    
    local selection=$(git status --porcelain | \
        fzf --tmux 90%,90% --multi --prompt='Git Status: ' \
            --preview='
                file=$(echo {} | awk "{print substr(\$0, 4)}")
                git_status=$(echo {} | cut -c1-2)
                echo "Status: $git_status"
                echo "File: $file"
                echo
                if [[ -f "$file" ]]; then
                    git diff --cached --color=always -- "$file" 2>/dev/null
                    git diff --color=always -- "$file" 2>/dev/null
                fi
            ' \
            --preview-window=down:70% \
            --expect=ctrl-a,ctrl-r \
            --header='C-a: stage | C-r: unstage')
    
    local key=$(echo "$selection" | head -1)
    local files=$(echo "$selection" | tail -n +2 | awk '{print substr($0, 4)}')
    
    if [[ -z "$files" ]]; then
        return 0
    fi
    
    if [[ "$key" == "ctrl-r" ]]; then
        echo "$files" | xargs -I {} git restore --staged -- {}
    elif [[ "$key" == "ctrl-a" ]]; then
        echo "$files" | xargs -I {} git add -- {}
    fi
}
