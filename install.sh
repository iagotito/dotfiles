#!/bin/sh

# check for zsh, tmux and asdf
requirements_not_found=""

if [ ! $(command -v zsh) &> /dev/null ]; then
    requirements_not_found="${requirements_not_found}zsh\n"
fi
if [ ! $(command -v tmux) &> /dev/null ]; then
    requirements_not_found="${requirements_not_found}tmux\n"
fi

if [ $requirements_not_found ]; then
    echo "The following programs were not found, but are recommended:"
    echo -e $requirements_not_found
    read -p "Continue installation? [y,n] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
    fi
fi

DOTFILES="$HOME/.dotfiles"
ZDOTDIR="$HOME/.config/zsh"

git clone --depth=1 --recurse-submodule https://github.com/iagotito/dotfiles $DOTFILES

echo "Copying .zshenv files to $HOME"
cp $DOTFILES/zsh/zshenv $HOME/.zshenv
echo "Copying others zsh files to $ZDOTDIR"
mkdir -p $ZDOTDIR
cp $DOTFILES/zsh/zshrc $ZDOTDIR/.zshrc
cp -r $DOTFILES/zsh/plugins $ZDOTDIR

echo "Copying .tmux.conf file to $HOME"
cp $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf

echo "Creating an empty personal-aliases file to avoid error after installation"
touch $DOTFILES/personal-aliases

echo "Instalation complete. Restart your zsh and tmux server to see the changes."
