
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

# I link to install my dotfiles in here, so I can use the same ones across all my users.
# If you prefer, you can skip this block and just to a git clone in your home or any place you like.
sudo mkdir /srv/dotfiles
sudo chmod 777 /srv/dotfiles
git clone --recurse-submodules git@github.com:iagotito/dotfiles.git /srv/dotfiles
git config --global --add safe.directory /srv/dotfiles
```

Then go to setuper to setup everything else.

```shell
cd /srv/dotfiles/setuper
./setuper help
```

### Full Instalation

```shell
cd /srv/dotfiles/setuper
./setuper all
```

See [setuper](https://github.com/iagotito/setuper).

## Requisites

These are dotfiles mainly to zsh and tmux, so you need to have them
installed in order to use it well.
