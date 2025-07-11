#!/usr/bin/zsh

###############################
# EXPORT ENVIRONMENT VARIABLE #
###############################

export DOTFILES="$HOME/.dotfiles"
export PRIVATE_DOTFILES="$HOME/.private-dotfiles"

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/cache
export XDG_CURRENT_DESKTOP=hyprland

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

# asdf
export ASDF_DIR="$HOME/.asdf"
export ASDF_DATA_DIR=$ASDF_DIR
export PATH=$ASDF_DIR/bin:$PATH
export PATH=$ASDF_DIR/shims:$PATH

export PATH="$HOME/.local/bin:$PATH"

export TMPDIR=/var/tmp

# kubernetes
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export PATH="$DOTFILES/global-packages/python:$PATH"
export PATH="$DOTFILES/global-packages/nodejs:$PATH"
export PATH="$DOTFILES/global-packages/golang:$PATH"

. "$HOME/.cargo/env"
