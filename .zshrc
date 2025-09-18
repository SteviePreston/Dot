# Export Paths
# Starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"
# K9s
export XDG_CONFIG_HOME="$HOME/.config"
# HomeBrew
export PATH="/opt/homebrew/bin:$PATH"
# Go 
export PATH=$PATH:$(go env GOPATH)/bin
# Node Version Manager
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
 
# Zsh auto suggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=yellow'
# Tmux 
source ~/.config/tmux/tmux.conf
# Bash
source ~/.config/bin/setup.sh

# Alias
alias nv="nvim"
alias tf="terraform"
alias la='ls -Fal'
alias ls='ls -F'
alias cdr='project-root'
alias hist='history-exec'

# Keybinds
bindkey '^G' autosuggest-accept
bindkey '^P' project-nav-func
bindkey '^H' history-exec-func
bindkey '^T' tmux-session-func
