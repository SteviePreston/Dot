# Starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# Export Paths
# HomeBrew
export PATH="/opt/homebrew/bin:$PATH"
# Go 
export PATH=$PATH:$(go env GOPATH)/bin
# Node Version Manager
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
export HISTSIZE=2500
 
# Zsh auto suggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=yellow'
bindkey '^G' autosuggest-accept

# Tmux 
source ~/.config/tmux/tmux.conf

# Alias
alias nv="nvim"
alias tf="terraform"
alias la='ls -Fal'
alias ls='ls -F'
alias fga='fuzzygitadd'
alias fgr='fuzzygitreset'
alias fgd='fuzzygitdiffcommit'
alias fgco='fuzzygitcheckout'
alias fof='fuzzyopenfile'
alias fcd='fuzzyopendir'
alias frg='fuzzyripgrep'
alias fh='fuzzyhistorycmd'
alias fk='fuzzyprocesskill'


# Helper Functions
fuzzygitadd() {
  git status --short | awk '{print $2}' | \
    fzf -m --preview 'git diff --color=always {}' \
    --preview-window=up:60%:wrap | xargs -r git add
}

fuzzygitreset() {
  git status --short | awk '{print $2}' | \
    fzf -m --preview 'git diff --color=always {}' \
    --preview-window=up:60%:wrap | xargs -r git restore
}

fuzzygitcheckout() {
  git checkout \
    "$(git branch --all | grep -v HEAD | sed 's/.* //' | sort -u | fzf)"
}

fuzzygitdiffcommit() {
  local commit
  commit=$(git log --pretty=oneline --abbrev-commit | \
    --preview-window=up:60%:wrap | awk '{print $1}')
  [ -n "$commit" ] && git diff "$commit"
}

fuzzyopenfile() {
  local file
  file=$(fzf \
    --preview 'bat --style=numbers --color=always --theme=Dracula \
    --line-range=:500 {}' --preview-window=up:60%:wrap --prompt="Open file: ")
  [ -n "$file" ] && nvim "$file"
}

fuzzyopendir() {
  local dir
  dir=$(find . -type d -not -path '*/\.*' | \
    fzf --preview 'ls -harl {} | head -30' \
    --preview-window=up:60%:wrap \
    --prompt="Choose directory: ")
  [ -n "$dir" ] && cd "$dir"
}

fuzzyhistorycmd() {
  local cmd
  cmd=$(history | \
    awk '{$1=""; print substr($0,2)}' | \
    sort -u | \
    fzf --preview 'echo "Execute: {}"' \
    --preview-window=up:15%:wrap \
    --prompt="Choose command: " \
    --height=20% \
    --reverse)
  [ -n "$cmd" ] && eval "$cmd"
}

fuzzyprocesskill() {
  local pid
  pid=$(ps -eo pid,ppid,pcpu,pmem,comm | \
    fzf --header-lines=1 \
    --preview 'ps -p $(echo {} | awk "{print \$1}") -o pid,ppid,pcpu,pmem,etime,comm 2>/dev/null || echo "Process details unavailable"' \
    --preview-window=up:40% \
    --prompt="Kill process: " | \
    awk '{print $1}')
  
  if [ -n "$pid" ]; then
    echo "Killing process $pid..."
    kill -9 "$pid" 2>/dev/null && echo "Process $pid killed" || echo "Failed to kill process $pid"
  fi
}
