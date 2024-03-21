function source_if_exists() {
  [ -f "$1" ] && source "$1"
}

source_if_exists "${xdg_data_home:-$home/.local/share}/zap/zap.zsh"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "chivalryq/git-alias"
plug "MichaelAquilina/zsh-you-should-use"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init --cmd cd zsh)"

eval "$(starship init zsh)"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/alan/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# protoc
export PATH="$HOME/.local/bin:$PATH"

# go
export PATH="/usr/local/go/bin:$PATH"

export PATH="$HOME/.local/scripts:$PATH"

# See bin/.local/scripts/tmux-sessionizer
bindkey -s "^f" "tmux-sessionizer\n"

source_if_exists "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/functions.zsh"
