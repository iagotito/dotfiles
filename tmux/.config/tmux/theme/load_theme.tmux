#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

main()
{
  # set scripts dir variable
  theme_dir="$HOME/.config/tmux/theme"

  # set configuration option variables
  show_left_icon="smiley"
  show_left_icon_padding="0"
  show_left_sep=""
  show_right_sep=""
  show_cpu_usage="false"
  show_cpu_temp="false"
  show_ram_usage="false"
  show_day_month="false"
  show_time="false"
  show_refresh="5"

  # Based on Dracula Color Palette, but with bright colors
  #white='#f8f8f2'
  #gray='#181B28'
  #dark_gray='#282a36'
  #light_purple='#9d5ef7'
  #dark_purple='#472c91'
  #cyan='#00d2ff'
  #green='#00ff00'
  #orange='#ff8400'
  #red='#ff5555'
  #pink='#ff00ff'
  #yellow='#ffff00'

  # Based on Dracula Color Palette, but with some slight bright colors
  white="#f8f8f2"
  gray="#44475a"
  dark_gray="#282a36"
  light_purple="#bd93f9"
  dark_purple="#6272b4"
  cyan="#6be9fd"
  green="#50ff74"
  orange="#fbb85c"
  red="#ff5555"
  pink="#ff79c6"
  yellow="#f1fa8c"
  bg_color="#282A36"

  # Original Dracula Color Palette
  #white="#f8f8f2"
  #gray="#44475a"
  #dark_gray="#282a36"
  #light_purple="#bd93f9"
  #dark_purple="#6272a4"
  #cyan="#8be9fd"
  #green="#50fa7b"
  #orange="#ffb86c"
  #red="#ff5555"
  #pink="#ff79c6"
  #yellow="#f1fa8c"


  # Handle left icon configuration
  case $show_left_icon in
      smiley)
          left_icon="☺";;
      session)
          left_icon="#S";;
      window)
          left_icon="#W";;
      *)
          left_icon=$show_left_icon;;
  esac

  # Handle left icon padding
  padding=""
  if [ "$show_left_icon_padding" -gt "0" ]; then
	  padding="$(printf '%*s' $show_left_icon_padding)"
  fi
  left_icon="$left_icon$padding"

  right_sep="$show_right_sep"
  left_sep="$show_left_sep"

  # sets refresh interval to every 5 seconds
  tmux set-option -g status-interval $show_refresh

  # set 24h clock
	tmux set-option -g clock-mode-style 24

  # set length
  tmux set-option -g status-left-length 57
  tmux set-option -g status-right-length 47

  # pane border styling
  tmux set-option -g pane-active-border-style "fg=${THEME_COLOR_4}"
  tmux set-option -g pane-border-style "fg=${THEME_COLOR_GRAY}"

  # message styling
  tmux set-option -g message-style "bg=${THEME_COLOR_GRAY},fg=${THEME_COLOR_WHITE}"

  # status bar
  tmux set-option -g status-style "bg=default,fg=${THEME_COLOR_WHITE}"

  # Powerline Configuration
  tmux set-option -g status-left "#[bg=${THEME_COLOR_7},fg=${THEME_COLOR_DARK_GRAY}]#{?client_prefix,#[bg=${yellow}],} ${left_icon} #[fg=${THEME_COLOR_7},bg=${bg_color}]#{?client_prefix,#[fg=${yellow}],}${left_sep}"

  # fg=black is the greatest trick I ever made
  # I wanted my status line to be the same color of my terminal background, but
  # I had trouble to do it since the backgorund color is a hex.
  # Do "bg=default" was not working, but when I do it black it becames almost
  # invisible with the dracula background.
  # Since I've already lost a lot of time trying to make it work, I will take
  # it as a victory.
  #tmux set-window-option -g window-status-current-format "#[fg=black,bg=${dark_purple}`:]${left_sep}#[fg=${THEME_COLOR_WHITE},bg=${dark_purple}] #I #W #[fg=${dark_purple},bg=default]${left_sep}"

  tmux set-window-option -g window-status-current-format "#[fg=${bg_color},bg=${dark_purple}]${left_sep}#[fg=${THEME_COLOR_WHITE},bg=${dark_purple}] #I #W #[fg=${dark_purple},bg=default]${left_sep}"

  tmux set-window-option -g window-status-format "#[fg=${THEME_COLOR_WHITE}]#[bg=default] #I #W${flags}"
  tmux set-window-option -g window-status-activity-style "bold"
  tmux set-window-option -g window-status-bell-style "bold"

  tmux set-option -g  status-right ""
  powerbg=default

  if $show_ram_usage; then
    tmux set-option -ga status-right "#[fg=${cyan},bg=${powerbg},nobold,nounderscore,noitalics] ${right_sep}#[fg=${dark_gray},bg=${cyan}] #($theme_dir/ram_info.sh)"
    powerbg=${cyan}
  fi

  if $show_cpu_usage; then
    tmux set-option -ga status-right "#[fg=${orange},bg=${powerbg},nobold,nounderscore,noitalics] ${right_sep}#[fg=${dark_gray},bg=${orange}] #($theme_dir/cpu_info.sh)"
    powerbg=${orange}
  fi

  if $show_cpu_temp; then
    tmux set-option -ga status-right  "#[fg=${THEME_COLOR_WHITE}] #($theme_dir/cpu_temp.sh)"
    powerbg=${orange}
  fi

  if $show_time; then
    if $show_day_month; then # dd/mm and 24h clock
      tmux set-option -ga status-right "#[fg=${dark_purple},bg=${powerbg},nobold,nounderscore,noitalics] ${right_sep}#[fg=${THEME_COLOR_WHITE},bg=${dark_purple}] %a %d/%m %R "
    else # only 24h clock
      tmux set-option -ga status-right "#[fg=${dark_purple},bg=${powerbg},nobold,nounderscore,noitalics] ${right_sep}#[fg=${THEME_COLOR_WHITE},bg=${dark_purple}] %a %R "
    fi
  fi
}

# run main function
main
