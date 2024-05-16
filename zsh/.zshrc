function source_if_exists() {
  [ -f "$1" ] && source "$1"
}

source_if_exists "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "chivalryq/git-alias"
plug "MichaelAquilina/zsh-you-should-use"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
eval "$(fzf --zsh)"
source_if_exists ~/.fzf.zsh

eval "$(zoxide init --cmd cd zsh)"

eval "$(starship init zsh)"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# See bin/.local/scripts/tmux-sessionizer
bindkey -s "^f" "tmux-sessionizer\n"

source_if_exists "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/functions.zsh"
