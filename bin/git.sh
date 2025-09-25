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

git-checkout() {
    git-check || return 1
    tmux-check || return 1
    
    local branch=$((git branch -a | grep -v HEAD | sed 's/^..//' | sed 's/remotes\/origin\///' | sort -u) | \
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

git-status() {
    git-check || return 1
    tmux-check || return 1
    
    git status --porcelain | \
    fzf --tmux 90%,90% --multi --prompt='Git Status: ' \
        --preview='
            file=$(echo {} | cut -c4-)
            git_status=$(echo {} | cut -c1-2)
            echo "Status: $git_status"
            echo "File: $file"
            echo
            if [[ -f "$file" ]]; then
                if [[ "$git_status" == *"A"* ]] || [[ "$git_status" == *"M"* ]] && git diff --cached --name-only | grep -q "^$file$"; then
                    echo "[STAGED CHANGES]"
                    git diff --cached --color=always "$file" 2>/dev/null
                fi
                if [[ "$git_status" == *"M"* ]] || [[ "$git_status" == " M" ]]; then
                    echo "[UNSTAGED CHANGES]"
                    git diff --color=always "$file" 2>/dev/null
                fi
            fi
        ' \
        --preview-window=down:70% \
        --bind='ctrl-a:execute-silent(git add {4..})+reload(git status --porcelain)' \
        --bind='ctrl-r:execute-silent(git restore {4..})+reload(git status --porcelain)' \
        --header='C-a: add | C-r: restore | Enter: view'
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


