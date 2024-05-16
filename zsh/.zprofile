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

add_to_path_front $HOME/.fzf/bin

export PNPM_HOME=$HOME/.local/share/pnpm
add_to_path_front $PNPM_HOME

add_to_path_front $HOME/.zig
add_to_path_front /usr/local/go/bin
