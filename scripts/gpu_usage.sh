#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/utils.sh

get_platform()
{
  case $(uname -s) in
    Linux)
      # use this option for when you know that there is an NVIDIA gpu, but you cant use lspci
      ignore_lspci=$(get_tmux_option "@themux-ignore-lspci" false)
      if [[ "$ignore_lspci" = true ]]; then
        echo "NVIDIA"
      else
        gpu=$(lspci -v | grep VGA | head -n 1 | awk '{print $5}')
        echo $gpu
      fi
      ;;

    Darwin)
      # WARNING: for this to work the powermetrics command needs to be run without password
      #   add this to the sudoers file, replacing the username and omitting the quotes.
      #   be mindful of the tabs: "username		ALL = (root) NOPASSWD: /usr/bin/powermetrics"
      echo "apple"
      ;;

    CYGWIN*|MINGW32*|MSYS*|MINGW*)
      # TODO - windows compatability
      ;;
  esac
}

get_gpu()
{
  gpu=$(get_platform)
  if [[ "$gpu" == NVIDIA ]]; then
    usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | awk '{ sum += $0 } END { printf("%d%%\n", sum / NR) }')
  elif [[ "$gpu" == apple ]]; then
    usage="$(sudo powermetrics --samplers gpu_power -i500 -n 1 | grep 'active residency' | sed 's/[^0-9.%]//g' | sed 's/[%].*$//g')%"
  else
    usage='unknown'
  fi
  normalize_percent_len $usage
}

main()
{
  # storing the refresh rate in the variable RATE, default is 5
  RATE=$(get_tmux_option "@themux-refresh-rate" 5)
  gpu_label=$(get_tmux_option "@themux-gpu-usage-label" "GPU")
  gpu_usage=$(get_gpu)
  echo "󰢮 $gpu_label $gpu_usage"
  sleep $RATE
}

# run the main driver
main
