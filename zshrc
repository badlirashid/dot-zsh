# .zshrc --- badli zshrc configuration

# Copyright (C) 2021 Badli Rashid

# Author  :    Badli Rashid <badli.rashid@yahoo.com>
# Created :    2021 Apr 13
# URL     :    https://git.sr.ht/~badli/dot-zsh
# Version :    0.0.1

# This file is NOT part of Zsh

# Licenses:

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Code:

# No setup if not an interactive shell
if [[ ! -o interactive ]] ; then
	return
fi

# Setup Default PATH
export HELPDIR=/usr/local/share/zsh/$ZSH_VERSION/help  # directory for run-help function to find docs

## Set a search path for the cd builtin
cdpath=(.. ~)

# automatically remove duplicates from these arrays
typeset -U path manpath cdpath fpath

# history 
HISTFILE=~/.histfile
HISTSIZE=1024
SAVEHIST=1024
setopt histignoredups	# Do not enter command lines into the history list if they are duplicates of the previous event.
setopt incappendhistory	# history lines are added to the $HISTFILE incrementally (as soon  as  they  are entered)

# setopt options
setopt beep
setopt COMPLETE_ALIASES # Prevents aliases on the command line from being internally substituted before completion is attempted.
setopt autocd		# Change directory without cd command
setopt autolist		# Automatically list choices on an ambiguous completion.
setopt globdots		# Do not require a leading `.' in a filename to be matched explicitly.
setopt extendedglob	# Treat the `#',  `~' and `^' characters as part of patterns for filename generation, etc.
setopt nomatch		# If a pattern  for  filename generation has no matches, print an error,
setopt notify		# Report the status of background jobs immediately.
setopt noclobber	# Disallows `>' redirection to truncate existing files
setopt longlistjobs	# Print job notifications in the long format by default.
setopt PROMPT_SUBST     # Parameter expansion, command substitution and arithmetic expansion are performed in prompts. eg vcs_info

bindkey -e
bindkey ' ' magic-space		# also do history expansion on space
bindkey '^I' complete-word	# complete on tab, leave expansion to _expand

zstyle :compinstall filename '/home/user/.zshrc'

autoload -Uz compinit run-help vcs_info
compinit
vcs_info

zstyle ':vcs_info:git:*:-all-' command /opt/bin/git
# vcs_info enable
zstyle ':vcs_info:*' disable bzr cdv cvs svn darcs mtn svk tla
# vcs_info disable
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
precmd () { vcs_info }

# For autocompletion with an arrow-key driven interface
zstyle ':completion:*' menu select

# Refresh PATH automatically
zstyle ':completion:*' rehash true

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# vcs_info prompt
PS1='%F{5}[%F{2}%n%F{5}] %F{3}%3~ ${vcs_info_msg_0_}%f%# '

# our prompt 
PROMPT='${vcs_info_msg_0_} %~ %# '
