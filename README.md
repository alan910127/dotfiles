# Dotfiles

Welcome to my dotfiles repository!
This collection contains my personalized configuration files for various development environments—crafted for speed, clarity, and comfort.

## 🚀 Installation

You can set up everything with a single command:

````sh
curl -fsSL https://raw.githubusercontent.com/alan910127/dotfiles/refs/heads/main/bootstrap | bash

```sh
curl -fsSL https://raw.githubusercontent.com/alan910127/dotfiles/refs/heads/main/bootstrap | bash
````

Alternatively, if curl isn't available:

```sh
wget -qO- https://raw.githubusercontent.com/alan910127/dotfiles/refs/heads/main/bootstrap | bash
```

> [!IMPORTANT]
> This script will symlink configuration files and install essential tools.
> Make sure to review the script before running it if you're cautious (which you should be!).

## 📁 What's Included?

- Zsh configuration (.zshrc, plugins, themes)
- Neovim setup
- Git configuration
- Tmux layout
- Other CLI tools and aliases

## 🧪 Dry Run Preview

Curious what the script will do? You can run it with `--dry` to preview the steps without making any changes:

```sh
bash bootstrap --dry
```

Example output:

```
2025-04-09 06:25:16 [info ] [DRY RUN] OS detected: Arch Linux
2025-04-09 06:25:16 [info ] [DRY RUN] Installing 'bat'
2025-04-09 06:25:16 [info ] [DRY RUN] Installing 'delta'
2025-04-09 06:25:16 [info ] [DRY RUN] Installing 'eza'
2025-04-09 06:25:16 [info ] [DRY RUN] Installing 'fd'
2025-04-09 06:25:16 [info ] [DRY RUN] Installing 'fzf'
2025-04-09 06:25:16 [info ] [DRY RUN] Installing 'git'
2025-04-09 06:25:16 [info ] [DRY RUN] Installing 'neovim'
2025-04-09 06:25:16 [info ] [DRY RUN] Installing 'ripgrep'
2025-04-09 06:25:16 [info ] [DRY RUN] Installing 'stow'
2025-04-09 06:25:16 [info ] [DRY RUN] Installing 'tmux'
2025-04-09 06:25:16 [info ] [DRY RUN] Installing 'zoxide'
2025-04-09 06:25:16 [info ] [DRY RUN] Installing 'zsh'
2025-04-09 06:25:16 [info ] [DRY RUN] Cloning repository to '/home/alan/.dotfiles'
2025-04-09 06:25:16 [info ] [DRY RUN] Stowing '/home/alan/.dotfiles/home' to '/home/alan'
2025-04-09 06:25:16 [info ] [DRY RUN] Setting up tmux plugin manager
```

## ⚠️ Caveat

This setup is primarily developed and tested on **Arch Linux**.  
Basic support for **Ubuntu** is included, but it may be incomplete (e.g., missing package names or dependencies).
