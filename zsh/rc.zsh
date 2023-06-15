function source_if_exists() {
  if [ -f $1 ]; then
    source $1
  fi
}

export DOTFILES=$HOME/repo/dotfiles

source_if_exists $DOTFILES/zsh/alias.zsh

# zsh plugins
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
source ${ZSH_CUSTOM}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ${ZSH_CUSTOM}/plugins/zsh-completions/zsh-completions.plugin.zsh

# nvm
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

# Enable Starship
eval "$(starship init zsh)"