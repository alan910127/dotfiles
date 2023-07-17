#!/usr/bin/env zsh

DOTFILES=$(pwd -P)

set -e

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Create symlinks
symlink() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ]; then
        echo "File '$dest' already exists, skipping..."
        return
    fi

    echo "Linking: $dest -> $src"
    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
}

link_files() {
    local src dest file

    for file in $(find . -type f -name links.prop); do
        cat "$file" | while read line || [ -n "$line" ]; do
            src=$(eval echo "$line" | cut -d '=' -f1)
            dest=$(eval echo "$line" | cut -d '=' -f2)
            symlink "$src" "$dest"
        done
    done
}

link_files

source ~/.zshrc
