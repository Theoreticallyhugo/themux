# themux
my dracula based tmux plugin.

i am building this for myself and publish it for ease of deployment. features may well break and not get fixed, so beware.

# usage

## plugins
- `"cwd"`
- `"fossil"`
- `"git"`
- `"hg"`
- `"battery"`
- gpu info
    - `"gpu-usage"`
    - `"gpu-ram-usage"`
    - `"gpu-power-draw"`
- cpu info
    - `"cpu-usage"`
    - `"ram-usage"`
    - `"tmux-ram-usage"`
- network info
    - `"network"`
    - `"network-bandwidth"`
    - `"network-ping"`
    - `"network-vpn"`
- `"attached-clients"`
- `"mpc"`
- `"spotify-tui"`
- music info
    - `"playerctl"`
    - `"kubernetes-context"`
- `"terraform"`
- `"continuum"`
- `"weather"`
- `"time"`
- `"synchronize-panes"`
- `"ssh-session"`
- tailscale info
    - `"tailupdate"`
    - `"tailexit"`
## options
how to use options
`set -g @name-of-option "values for option"`
- `set -g @themux-plugins "name of plugins in order they are to be displayed"`
- `set -g @themux-git-no-repo-message "message"`
- `set -g @themux-time-colors "background_colour foreground_colour"`

## available colours
use one of these predefined colours or use hexcodes like this `#FFFFFF`

## issues
- if you have an nvidia gpu, but cant use lspci
    - set -g @dracppuccin-ignore-lspci true
- if youre still using dracula options, use `sed -i "" -e "s/@dracula-/@themux-/g" <filename(s)>` to migrate


## LICENSE
this plugin is based on the [dracula tmux](https://github.com/dracula/tmux) plugin, published under the MIT license at the time of forking. the original license can be found in the file LICENSE_OLD.

the colourscheme is based on [catppuccin](https://github.com/catppuccin/catppuccin).

this project is published under the AGPLv3. the active license can be found in the file LICENSE.

