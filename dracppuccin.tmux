#!/usr/bin/env bash

#    tmux plugin based on dracula functionalities and catppuccin colours
#    Copyright (C) 2024  Hugo Meinhof
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published
#    by the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.


# source and run dracppuccin theme

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$current_dir/scripts/dracppuccin.sh

