#/bin/sh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Create symlinks
parse_link() {
    local line=$1
    local source=$(eval echo "$line" | cut -d'=' -f1)
    local target=$(eval echo "$line" | cut -d'=' -f2)

    if [ -f "$target" ]; then
        echo "File $target already exists. Skipping..."
    else
        mkdir -p $(dirname "$target")
        ln -s "$source" "$target"
    fi
}

for file in $(find . -type f -name links.prop); do
    cat "$file" | while read line || [ -n "$line" ]; do
        source=$(eval echo "$line" | cut -d'=' -f1)
        target=$(eval echo "$line" | cut -d'=' -f2)

        if [ -f "$target" ]; then
            echo "File $target already exists. Skipping..."
        else
            mkdir -p $(dirname "$target")
            ln -s "$source" "$target"
        fi
    done
done

source ~/.zshrc
