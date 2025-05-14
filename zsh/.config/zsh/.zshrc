#!/usr/bin/zsh

# Terminal colors

# Function to set Dracula theme colors
set_dracula_theme() {
    # Define raw colors
    local BACKGROUND="#282A36"
    local CURRENT_LINE="#44475A"
    local FOREGROUND="#F8F8F2"
    local WHITE="#F8F8F2"
    local COMMENT="#6272A4"
    local CYAN="#8BE9FD"
    local GREEN="#50FA7B"
    local ORANGE="#FFB86C"
    local PINK="#FF79C6"
    local PURPLE="#BD93F9"
    local RED="#FF5555"
    local YELLOW="#F1FA8C"
    local GRAY="#2E3436"
    local DARK_GRAY="#282a36"
    local BLUE="#5D7BE6"

    # Export colors in hex gradient order: red > blue > green
    export THEME_COLOR_0="$RED"
    export THEME_COLOR_1="$ORANGE"
    export THEME_COLOR_2="$PINK"
    export THEME_COLOR_3="$YELLOW"
    export THEME_COLOR_4="$PURPLE"
    export THEME_COLOR_5="$CYAN"
    export THEME_COLOR_6="$BLUE"
    export THEME_COLOR_7="$GREEN"
    export THEME_COLOR_WHITE="$WHITE"
    export THEME_COLOR_GRAY="$GRAY"
    export THEME_COLOR_DARK_GRAY="$GRAY"

    # Export other non-color variables
    export THEME_BACKGROUND="$BACKGROUND"
    export THEME_CURRENT_LINE="$CURRENT_LINE"
    export THEME_FOREGROUND="$FOREGROUND"
    export THEME_COMMENT="$COMMENT"
}

# Function to set Catppuccin theme colors
set_catppuccin_theme() {
    # Define raw colors
    local ROSEWATER="#f5e0dc"
    local FLAMINGO="#f2cdcd"
    local PINK="#f5c2e7"
    local MAUVE="#cba6f7"
    local RED="#f38ba8"
    local MAROON="#eba0ac"
    local PEACH="#fab387"
    local YELLOW="#f9e2af"
    local GREEN="#7ee379" #"a6e3a1"
    local TEAL="#94e2d5"
    local SKY="#89dceb"
    local SAPPHIRE="#74c7ec"
    local BLUE="#89b4fa"
    local LAVENDER="#b4befe"
    local TEXT="#cdd6f4"
    local SUBTEXT1="#bac2de"
    local SUBTEXT0="#a6adc8"
    local OVERLAY2="#9399b2"
    local OVERLAY1="#7f849c"
    local OVERLAY0="#6c7086"
    local SURFACE2="#585b70"
    local SURFACE1="#45475a"
    local SURFACE0="#313244"
    local BASE="#1e1e2e"
    local MANTLE="#181825"
    local CRUST="#11111b"

    # Export colors in hex gradient order: red > blue > green (matched to Dracula's colors)
    export THEME_COLOR_0="$RED"
    export THEME_COLOR_1="$PEACH"
    export THEME_COLOR_2="$PINK"
    export THEME_COLOR_3="$YELLOW"
    export THEME_COLOR_4="$MAUVE"
    export THEME_COLOR_5="$SAPPHIRE"
    export THEME_COLOR_6="$BLUE"
    export THEME_COLOR_7="$GREEN"
    export THEME_COLOR_WHITE="$ROSEWATER"
    export THEME_COLOR_GRAY="$SURFACE2"
    export THEME_COLOR_DARK_GRAY="$SURFACE0"

    # Export other non-color variables
    export THEME_BACKGROUND="$BASE"
    export THEME_CURRENT_LINE="$SURFACE1"
    export THEME_FOREGROUND="$TEXT"
    export THEME_COMMENT="$OVERLAY1"
}

# Function to switch themes
set_theme() {
    case "$1" in
        "dracula")
            set_dracula_theme
            ;;
        "catppuccin")
            set_catppuccin_theme
            ;;
        *)
            echo "Unknown theme: $1"
            return 1
            ;;
    esac
}

# Example usage
set_theme "catppuccin"
#set_theme "dracula"

# prompt configuration

fpath=($ZDOTDIR/prompt $fpath)
autoload -Uz prompt_setup; prompt_setup

# zhistory

setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS

# zsh directory stack

setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
alias ds='dirs -v'  # directy stack
                    # 'd' is used to deactivate python venvs (see $DOTFILES/aliases)
for index ({1..9}) alias "$index"="cd +${index}"; unset index


if [[ -f "$PRIVATE_DOTFILES/private-zshrc" ]]; then
    source "$PRIVATE_DOTFILES/private-zshrc"
fi

# aliases
source "$DOTFILES/aliases"
if [[ -f "$PRIVATE_DOTFILES/private-aliases" ]]; then
    source "$PRIVATE_DOTFILES/private-aliases"
fi

# functions
source "$DOTFILES/functions"
if [[ -f "$PRIVATE_DOTFILES/private-functions" ]]; then
    source "$PRIVATE_DOTFILES/private-functions"
fi

# variables
if [[ -f "$PRIVATE_DOTFILES/private-variables" ]]; then
    source "$PRIVATE_DOTFILES/private-variables"
fi

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Vim mapping for completion

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# asdf
# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit; compinit -u
_comp_options+=(globdots) # With hidden files
source $ZDOTDIR/plugins/completion.zsh

# activate the syntax highlighting
# see: https://github.com/zsh-users/zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# activate the zsh auto sugestions
# see: https://github.com/zsh-users/zsh-autosuggestions
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable history substring search
setopt hist_subst_pattern

# Function to search command history with fzf
fh() {
  BUFFER=$(history 1 | fzf --tac | command tr -s ' ' | cut -d' ' -f3-)
  print -z $BUFFER
}

# Bind the function to a shortcut (Ctrl+R in this case)
zle -N fh
bindkey '^r' fh
#if [[ -n "$TMUX" ]]; then
  #tmux unbind-key -n C-r
  #tmux bind-key -n R run-shell "tmux send-keys -t=:.$(tmux display -p '#{session_id}') C-r"
#fi

# if tmux is installed,
# starts new terminal with a tmux session and close it when quit tmux

if [ "$AUTO_USE_TMUX" = "true" ] && \
  [[ -x "$(command -v tmux)" ]] && \
  [ -t 0 ] && \
  [[ -z $TMUX ]] &&\
  [[ $- = *i* ]]; then
  exec tmux;
fi

# append snap to PATH
path+=('/snap/bin')

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setup colors

# change highlight colors to dracula colors
# from file: zsh-syntax-highlighting/highlighters/main/main-highlighter.zsh
ZSH_HIGHLIGHT_STYLES[default]=$FOREGROUND
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=$THEME_COLOR_0,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=$THEME_COLOR_3
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=$THEME_COLOR_7,underline
ZSH_HIGHLIGHT_STYLES[global-alias]=fg=$THEME_COLOR_5
ZSH_HIGHLIGHT_STYLES[precommand]=fg=$THEME_COLOR_7,underline
ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=$THEME_COLOR_7,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=$THEME_COLOR_4
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=$THEME_COLOR_4
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=$THEME_COLOR_2
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=$THEME_COLOR_2
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=$THEME_COLOR_2
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=$THEME_COLOR_3
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=$THEME_COLOR_3
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=$THEME_COLOR_3
ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=$THEME_COLOR_5
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=$THEME_COLOR_5
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=$THEME_COLOR_5
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=$THEME_COLOR_5
ZSH_HIGHLIGHT_STYLES[redirection]=fg=$THEME_COLOR_3
ZSH_HIGHLIGHT_STYLES[arg0]=fg=$THEME_COLOR_7

export EZA_CONFIG_DIR="$HOME/.config/eza"

fpath+=${ZDOTDIR:-~}/.zsh_functions
