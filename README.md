# Dotfiles

Welcome to my dotfiles repository!
This collection contains my personalized configuration files tailored for various development environments.

## Installation

To begin using these dotfiles, clone this repository to your preferred location:

```bash
git clone https://github.com/alan910127/.dotfiles.git ~/.dotfiles
```

After cloning, navigate into the dotfiles directory:

```bash
cd ~/.dotfiles
```

Since these configurations are organized to reflect their placement in the home directory, you can now utilize [GNU Stow](https://www.gnu.org/software/stow/) to seamlessly symlink them:

For instance, to symlink the configuration for Neovim:

```bash
stow -t ~ nvim
```

Once the applications are stowed, feel free to start using them immediately.
However, if the configurations are not applied as expected, reopen your shell to ensure the changes take effect.

## Notes

For an enhanced experience with these configurations, ensure you have the following tools installed:

- [junegunn/fzf](https://github.com/junegunn/fzf)
- [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)
- [ajeetdsouza/zoxide](https://github.com/ajeetdsouza/zoxide)

These dependencies complement the functionality of the configured tools and contribute to a smoother workflow.
