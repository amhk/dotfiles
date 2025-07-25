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
[ -f "/usr/share/bash-completion/bash_completion" ] && source "/usr/share/bash-completion/bash_completion"
[ -f "$HOME/.config/bash/git-completion.bash" ] && source "$HOME/.config/bash/git-completion.bash"
[ -f "$HOME/.config/bash/git-prompt.sh" ] && source "$HOME/.config/bash/git-prompt.sh"
[ -f "$HOME/.config/fzf/key-bindings.bash" ] && source "$HOME/.config/fzf/key-bindings.bash"


# bash setup
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
export COLORTERM=truecolor
shopt -s histappend
shopt -s checkwinsize


# aliases
alias ls='eza'
alias dotfiles='git --git-dir="${HOME}"/.dotfiles.git --work-tree="${HOME}"'
alias i3lock='i3lock -c "#000000"'
alias groot='git rev-parse --is-inside-work-dir >/dev/null && cd "$(git rev-parse --show-toplevel)"'
alias vim='nvim'
alias view='nvim -R'
alias nview=view
alias rgg='rg --no-heading --with-filename --line-number'


# exports
export EDITOR=nvim
export PATH="$HOME/bin:$HOME/local/bin:$HOME/.fzf/bin:$PATH"
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/config


# bindings
# \eOP is F1 (found by typing `ctrl-v f1` in a bash shell)
bind -x '"\eOP"':'"fzf | xargs -ro nvim"'


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

    # hostname (if ssh)
    local hostname hostname_padding
    if [[ -n "${SSH_CLIENT}" ]]; then
        hostname="$(hostname -s)"
        hostname_padding=" "
    fi

    # path (tree/leaf, with leaf in different color)
    local path leaf tree available padding
    path="${PWD/$HOME/'~'}"
    leaf="$(basename "$path")"
    tree="${path%$leaf}"
    available=$((COLUMNS - ${#retval} - ${#git} - ${#hostname} - ${#hostname_padding} - ${#leaf}))
    if [ ${#tree} -gt ${available} ]; then
        tree="...${tree: -$((available - 3))}"
        padding=${#leaf}
    else
        padding=$((COLUMNS - ${#retval} - ${#git} - ${#hostname} - ${#hostname_padding} - ${#tree}))
    fi

    # assemble prompt
    export PS1
    local black_on_cyan red yellow cyan CYAN reset
    black_on_cyan='\e[46;30m'
    red='\e[0;31m'
    yellow='\e[0;33m'
    cyan='\e[0;36m'
    CYAN='\e[1;36m'
    reset='\e[39;49m'
    PS1=$(printf "${black_on_cyan}%s${reset}%s${cyan}%s${CYAN}%-${padding}s${yellow}%s${red}%s${reset}\n\\$ " \
        "$hostname" "$hostname_padding" \
        "$tree" "$leaf" \
        "$git" "$retval"
    )
}
export PROMPT_COMMAND=_prompt_command
