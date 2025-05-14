#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

main()
{
  # set scripts dir variable
  theme_dir="$HOME/.config/tmux/themes/catppuccin"

  # set configuration option variables
  show_left_icon="icon"
  show_left_icon_padding="0"
  show_left_sep=""
  show_right_sep=""
  show_cpu_usage="true"
  show_cpu_temp="false"
  show_ram_usage="true"
  show_day_month="true"
  show_time="true"
  show_refresh="5"

  # Based on Catppuccin color palette
  white="#f8f8f2"
  gray="#44475a"
  dark_gray="#282a36"
  light_purple="#bd93f9"
  dark_purple="#6272b4"
  cyan="#6be9fd"
  orange="#fbb85c"
  red="#ff5555"
  pink="#ff79c6"
  bg_color="#282A36"

  lavender="#b4befe"
  crust="#11111b"
  green="#a6e3a1"
  yellow="#f9e2af"

  # Handle left icon padding
  padding=""
  if [ "$show_left_icon_padding" -gt "0" ]; then
	  padding="$(printf '%*s' $show_left_icon_padding)"
  fi
  left_icon="$left_icon$padding"

  right_sep="$show_right_sep"
  left_sep="$show_left_sep"

  # set length
  tmux set-option -g status-left-length 57
  tmux set-option -g status-right-length 47

  # pane border styling
  tmux set-option -g pane-active-border-style "fg=${light_purple}"
  tmux set-option -g pane-border-style "fg=${gray}"

  # message styling
  tmux set-option -g message-style "bg=${gray},fg=${white}"

  # status bar
  tmux set-option -g status-style "bg=default,fg=${white}"

  # Powerline Configuration
  tmux set-option -g status-left "#[bg=${green},fg=${dark_gray}]#{?client_prefix,#[bg=${yellow}],} ${left_icon} #[fg=${green},bg=${bg_color}]#{?client_prefix,#[fg=${yellow}],}${right_sep}"

  #tmux set-window-option -g window-status-current-format "#[fg=black,bg=${dark_purple}`:]${left_sep}#[fg=${white},bg=${dark_purple}] #I #W #[fg=${dark_purple},bg=default]${left_sep}"

  tmux set-window-option -g window-status-current-format "#[fg=${lavender}]${left_sep}#[fg=${crust},bg=${lavender}] #I #W #[fg=${lavender},bg=default]${right_sep}"

  tmux set-window-option -g window-status-format "#[fg=${white}]#[bg=default] #I #W${flags}"
  tmux set-window-option -g window-status-activity-style "bold"
  tmux set-window-option -g window-status-bell-style "bold"

  tmux set-option -g status-right ""
  powerbg=default
}

# run main function
main
