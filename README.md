# Iago's Dotfiles

My attempt to create some nice dotfiles to me.

## Instalation

### Zsh dotfiles setup

Run the following:

`sudo ls` is just a trick to grant the shell sudo privileges (required for the setup script)
```shell
sudo apt update -y
sudo apt install git -y

git config --global user.name "<YOUR NAME>"
git config --global user.email "<YOUR EMAIL>"

# Setup the ssh agent. Requires an id_ed25519 ssh key, or you can change to your's.
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

git clone --recurse-submodules git@github.com:iagotito/dotfiles.git ~/.dotfiles
```

Then go to setuper to setup everything else.

```shell
cd $HOME/.dotfiles/setuper
./setuper help
```

See [setuper](https://github.com/iagotito/setuper).

## Requisites

These are dotfiles mainly to zsh and tmux, so you need to have them
installed in order to use it well.
