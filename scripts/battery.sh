#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/utils.sh

# approximate time until what?
# pmset -g batt | sed -n 2p | cut -d ';' -f 3 | cut -d ' ' -f 2
#
#         
#     
# 
# 󰂎󰁺󰁻󰁼󰁽󰁾󰁿󰂀󰂁󰂂󰁹 󰂃󰂅 󰂆 󰂇 󰂈 󰂉 󰂊 󰂋 󰂌 󰂍 󰂎 󰂏 󰂑 󱈏 󱈐 󱈑 󱉝 󱉞 󱊡󱊢󱊣󱊤 󱊥 󱊦 󱟞 󱟟 󱟠 󱟡 󱟢 󱟣 󱟤 󱟥 󱟦 󱟧 󱟨 󱟩 󱧥 󱧦

linux_acpi() {
  arg=$1
  BAT=$(ls -d /sys/class/power_supply/*)
  if [ ! -x "$(which acpi 2> /dev/null)" ];then
    case "$arg" in
      status)
        cat $BAT/status
        ;;

      percent)
        cat $BAT/capacity
        ;;

      *)
        ;;
    esac
  else
    case "$arg" in
      status)
        acpi | cut -d: -f2- | cut -d, -f1 | tr -d ' '
        ;;
      percent)
        acpi | cut -d: -f2- | cut -d, -f2 | tr -d '% '
        ;;
      *)
        ;;
    esac
  fi
}

battery_percent()
{
  # Check OS
  case $(uname -s) in
    Linux)
      percent=$(linux_acpi percent)
      [ -n "$percent" ] && echo " $percent"
      ;;

    Darwin)
      echo $(pmset -g batt | grep -Eo '[0-9]?[0-9]?[0-9]%')
      ;;

    FreeBSD)
      echo $(apm | sed '8,11d' | grep life | awk '{print $4}')
      ;;

    CYGWIN*|MINGW32*|MSYS*|MINGW*)
      # leaving empty - TODO - windows compatability
      ;;

    *)
      ;;
  esac
}

battery_status()
{
  # Check OS
  case $(uname -s) in
    Linux)
      status=$(linux_acpi status)
      ;;

    Darwin)
      status=$(pmset -g batt | sed -n 2p | cut -d ';' -f 2 | tr -d " ")
      ;;

    FreeBSD)
      status=$(apm | sed '8,11d' | grep Status | awk '{printf $3}')
      ;;

    CYGWIN*|MINGW32*|MSYS*|MINGW*)
      # leaving empty - TODO - windows compatability
      ;;

    *)
      ;;
  esac

  bat_perc=$(battery_percent | sed "s/%//")
  # bat_perc=9 # for testing purposes
  # 󰂎󰁺󰁻󰁼󰁽󰁾󰁿󰂀󰂁󰂂󰁹

  case $status in
    discharging|Discharging)
      # discharging, no AC
      if [ $bat_perc -lt 10 ]; then
        echo "󰂎"
      elif [[ $bat_perc -lt 20 ]]; then
        echo "󰁺"
      elif [[ $bat_perc -lt 30 ]]; then
        echo "󰁻"
      elif [[ $bat_perc -lt 40 ]]; then
        echo "󰁼"
      elif [[ $bat_perc -lt 50 ]]; then
        echo "󰁽"
      elif [[ $bat_perc -lt 60 ]]; then
        echo "󰁾"
      elif [[ $bat_perc -lt 70 ]]; then
        echo "󰁿"
      elif [[ $bat_perc -lt 80 ]]; then
        echo "󰂀"
      elif [[ $bat_perc -lt 90 ]]; then
        echo "󰂁"
      elif [[ $bat_perc -lt 100 ]]; then
        echo "󰂂"
      else
        echo "󰁹"
      fi
      # echo $label
      ;;
    high|Full)
      echo "󰁹"
      ;;
    charging|Charging)
      # charging from AC
      if [ $bat_perc -lt 10 ]; then
        echo "󰂎"
      elif [[ $bat_perc -lt 20 ]]; then
        echo "󰁺"
      elif [[ $bat_perc -lt 30 ]]; then
        echo "󰁻"
      elif [[ $bat_perc -lt 40 ]]; then
        echo "󰁼"
      elif [[ $bat_perc -lt 50 ]]; then
        echo "󰁽"
      elif [[ $bat_perc -lt 60 ]]; then
        echo "󰁾"
      elif [[ $bat_perc -lt 70 ]]; then
        echo "󰁿"
      elif [[ $bat_perc -lt 80 ]]; then
        echo "󰂀"
      elif [[ $bat_perc -lt 90 ]]; then
        echo "󰂁"
      elif [[ $bat_perc -lt 100 ]]; then
        echo "󰂂"
      else
        echo "󰁹"
      fi
      # echo ''
      ;;
    ACattached)
      # drawing from AC but not charging
      echo ''
      ;;
    *)
      # something wrong...
      echo ''
      ;;
  esac
  ### Old if statements didn't work on BSD, they're probably not POSIX compliant, not sure
  # if [ $status = 'discharging' ] || [ $status = 'Discharging' ]; then
  # 	echo ''
  # # elif [ $status = 'charging' ]; then # This is needed for FreeBSD AC checking support
  # 	# echo 'AC'
  # else
  #  	echo 'AC'
  # fi
}

main()
{
  bat_label=$(get_tmux_option "@dracppuccin-battery-label" "")
  bat_stat=$(battery_status)
  bat_perc=$(battery_percent)

  if [ -z "$bat_stat" ]; then # Test if status is empty or not
    echo "$bat_label $bat_perc"
  elif [ -z "$bat_perc" ]; then # In case it is a desktop with no battery percent, only AC power
    echo ""
  else
    echo "$bat_label$bat_stat $bat_perc"
  fi
}

#run main driver program
main

