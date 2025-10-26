# Export Paths
export EDITOR=nvim
export VISUAL=nvim
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="/opt/homebrew/bin:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
 
# Load Config
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/bin/setup.sh
source <(starship init zsh)

# Alias
alias nv="nvim"
alias tf="terraform"
alias la="ls -Fal"
alias ls="ls -F"
alias cdr="project-root"
alias hist="history-exec"
alias fandr="find-replace"  
alias gcout="git-checkout"
alias glog="git-log"
alias gstat="git-status"
alias gtags="git-tag-checkout"
alias gclr="git clean -fd && git restore ."
alias config="cd ~/.config"

# Keybinds
bindkey "^L" autosuggest-accept
bindkey "^P" project-nav-func
bindkey "^H" history-exec-func
bindkey "^T" tmux-session-func
bindkey "^G" git-status-func
