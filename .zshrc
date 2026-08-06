# Environment Variables
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nvim

# Zsh Plugins
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias ll="ls -la"
alias v="nvim"
alias c="clear"
alias g="lazygit"
alias ta="tmux attach || tmux"

# Initialize Starship
eval "$(starship init zsh)"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
