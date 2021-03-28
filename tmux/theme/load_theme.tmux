#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

main()
{
  # set scripts dir variable
  theme_dir="$DOTFILES/tmux/theme"

  # set configuration option variables
  show_left_icon="smiley"
  show_left_icon_padding="0"
  show_left_sep=""
  show_right_sep=""
  show_cpu_usage="true"
  show_ram_usage="true"
  show_day_month="true"
  show_time="true"
  show_refresh="5"

  # Based on Dracula Color Pallette, but with bright colors
  white='#f8f8f2'
  gray='#181B28'
  dark_gray='#282a36'
  light_purple='#9d5ef7'
  dark_purple='#472c91'
  cyan='#00d2ff'
  green='#00ff00'
  orange='#ff8400'
  red='#ff0000'
  pink='#ff00ff'
  yellow='#ffff00'


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
  tmux set-option -g pane-active-border-style "fg=${light_purple}"
  tmux set-option -g pane-border-style "fg=${gray}"

  # message styling
  tmux set-option -g message-style "bg=${gray},fg=${white}"

  # status bar
  tmux set-option -g status-style "bg=${gray},fg=${white}"

  # Powerline Configuration
  tmux set-option -g status-left "#[bg=${green},fg=${dark_gray}]#{?client_prefix,#[bg=${yellow}],} ${left_icon} #[fg=${green},bg=${gray}]#{?client_prefix,#[fg=${yellow}],}${left_sep}"
  tmux set-option -g  status-right ""
  powerbg=${gray}

  if $show_ram_usage; then
    tmux set-option -ga status-right "#[fg=${cyan},bg=${powerbg},nobold,nounderscore,noitalics] ${right_sep}#[fg=${dark_gray},bg=${cyan}] #($theme_dir/ram_info.sh)"
    powerbg=${cyan}
  fi

  if $show_cpu_usage; then
    tmux set-option -ga status-right "#[fg=${orange},bg=${powerbg},nobold,nounderscore,noitalics] ${right_sep}#[fg=${dark_gray},bg=${orange}] #($theme_dir/cpu_info.sh)"
    powerbg=${orange}
  fi

  if $show_time; then
    if $show_day_month ; then # 24h clock and dd/mm
      tmux set-option -ga status-right "#[fg=${dark_purple},bg=${powerbg},nobold,nounderscore,noitalics] ${right_sep}#[fg=${white},bg=${dark_purple}] %a %d/%m %R ${timezone} "
    elif $show_day_month; then # only dd/mm
      tmux set-option -ga status-right "#[fg=${dark_purple},bg=${powerbg},nobold,nounderscore,noitalics] ${right_sep}#[fg=${white},bg=${dark_purple}] %a %d/%m %I:%M %p ${timezone} "
    else # only 24h clock
      tmux set-option -ga status-right "#[fg=${dark_purple},bg=${powerbg},nobold,nounderscore,noitalics] ${right_sep}#[fg=${white},bg=${dark_purple}] %a %m/%d %R ${timezone} "
    fi
  fi

  tmux set-window-option -g window-status-current-format "#[fg=${gray},bg=${dark_purple}]${left_sep}#[fg=${white},bg=${dark_purple}] #I #W #[fg=${dark_purple},bg=${gray}]${left_sep}"

  
  tmux set-window-option -g window-status-format "#[fg=${white}]#[bg=${gray}] #I #W${flags}"
  tmux set-window-option -g window-status-activity-style "bold"
  tmux set-window-option -g window-status-bell-style "bold"
}

# run main function
main
