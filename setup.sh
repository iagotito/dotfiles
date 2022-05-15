#!/usr/bin/bash

GIT_USER_NAME="Iago Tito Oliveira"
GIT_USER_EMAIL="iago.oliveira@ccc.ufcg.edu.br"
SSH_KEY="~/.ssh/id_ed25519"

ssh_setup() {
    eval "$(ssh-agent -s)"
    ssh-add $SSH_KEY
}

git_setup() {
    git config --global user.name "$GIT_USER_NAME"
    git config --global user.email "$GIT_USER_EMAIL"
}

sudo apt install -y make git

ssh_setup
git_setup

git clone --recurse-submodules git@github.com:iagotito/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

echo

make help
