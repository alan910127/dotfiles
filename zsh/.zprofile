function add_to_path() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$PATH:$1"
    fi
}

function add_to_path_front() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

add_to_path_front $HOME/.local/bin
add_to_path_front $HOME/.local/scripts

export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd7f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
add_to_path_front $HOME/.fzf/bin

export PNPM_HOME=$HOME/.local/share/pnpm
add_to_path_front $PNPM_HOME

add_to_path_front $HOME/.zig
add_to_path_front /usr/local/go/bin
