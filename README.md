
# Iago's Dotfiles

My attempt to create some nice dotfiles to me.

## Instalation

### Zsh dotfiles setup

Run the following:

`sudo ls` is just a trick to grant the shell sudo privileges (required for the setup script)
```shell
sudo ls > /dev/null &&
wget -q -O - https://raw.githubusercontent.com/iagotito/dotfiles/main/zsh_setup | bash
```

__Waring:__ it will override your `~/.zshenv` and
`~/.config/zsh/.zshrc` files so create a backup before.

### Full Instalation

Still working on this script.

## Requisites

These are dotfiles mainly to zsh and tmux, so you need to have them
installed in order to use it well.
