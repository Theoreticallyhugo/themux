#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

# 󰒪 󰒍 󰌗 󰌘

function get_isexitnode {
    # https://www.reddit.com/r/Tailscale/comments/18dirro/is_there_a_way_i_can_tell_which_exit_node_i_am/
    node=$(tailscale status --peers --json | jq '.ExitNodeStatus')
    if [[ -z $node ]] || [[ "$node"  == 'null' ]]; then
        echo ""
    else
        exitnode=$(tailscale status | grep "; exit node" | cut -w -f 2)
        echo "󰌘 $exitnode"
    fi
}

main()
{
  get_isexitnode
}

#run main driver function
main
