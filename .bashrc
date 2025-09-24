# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# baseline PATH if core tools not found
if ! command -v ls >/dev/null 2>&1; then
  export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

custom_path_add() {
    local new_path="$1"
    if [[ ":$PATH:" != *":$new_path:"* ]]; then
        export PATH="$PATH:$new_path"
    fi
}

custom_path_add "$HOME/.scripts"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env --shell bash)"   # force bash so it doesn’t “infer”
  fi
fi


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

gac() {
    args=("$@")
    message="${args[-1]}"

    if [ ! -e "$message" ]; then
        git add "${args[@]:0:${#args[@]}-1}" && git commit -m "$message"
    else
        echo "Missing commit message"
    fi
}

nginx-edit() {
    if [ -z "$1" ]; then
        echo "Usage: nginx-edit <site-name>"
        echo "Available sites:"
        ls /etc/nginx/sites-available/ 2>/dev/null | sed 's/^/  /'
        return 1
    fi

    local site_file="/etc/nginx/sites-available/$1"

    if [ ! -f "$site_file" ]; then
        echo "Error: $site_file does not exist"
        echo "Available sites:"
        ls /etc/nginx/sites-available/ 2>/dev/null | sed 's/^/  /'
        return 1
    fi

    echo "Editing nginx config for: $1"
    # Direct sudo nvim approach
    sudo /usr/bin/nvim/ +'set ft=nginx' "$site_file"

    # Optional: Ask if you want to test/reload nginx after editing
    read -p "Test nginx config and reload? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo nginx -t && sudo systemctl reload nginx
    fi
}

_nginx_edit_completion() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local -a sites
    mapfile -t sites < <(find /etc/nginx/sites-available/ -maxdepth 1 -type f -printf '%f\n' 2>/dev/null)
    COMPREPLY=($(compgen -W "${sites[*]}" -- "$cur"))
}

complete -F _nginx_edit_completion nginx-edit

PROMPT_CONFIG_FILE="$HOME/.prompt_config"

load_prompt_config() {
    if [[ -f "$PROMPT_CONFIG_FILE" ]]; then
        source "$PROMPT_CONFIG_FILE"
    else
        # Default values if no config file exists
        export PROMPT_CHARS="special"
    fi
}

save_prompt_config() {
    echo "export PROMPT_CHARS=\"$PROMPT_CHARS\"" > "$PROMPT_CONFIG_FILE"
    echo "Cfg file: $PROMPT_CONFIG_FILE"
}

toggle_prompt() {
    if [[ "$PROMPT_CHARS" == "special" ]]; then
        export PROMPT_CHARS="simple"
        echo "Special prompt chars disabled"
    else
        export PROMPT_CHARS="special"
        echo "Special prompt chars enabled - Nerd Font required"
    fi

    save_prompt_config 
    set_prompt
}

show_prompt_config() {
    echo "Prompt chars: $PROMPT_CHARS"
    echo "Config: $PROMPT_CONFIG_FILE"
}

load_prompt_config
alias prompt='toggle_prompt'
source "$HOME"/.git-prompt.sh

function set_prompt() {
    local R="\[\e[0m\]" # reset
    local RED="${R}\[\e[1;31m\]"
    local GRN="${R}\[\e[1;32m\]"
    local BLU="${R}\[\e[1;34m\]"
    # local DRED="${R}\[\e[1;2;31m\]"
    local DGRN="${R}\[\e[1;2;32m\]"
    # local DBLU="${R}\[\e[1;2;34m\]"

    if [[ $PROMPT_CHARS == "special" ]]; then
        local leadSym="${GRN} 󰀝 "
        local pSymbol="${GRN}→ ${R}"
    else
        local leadSym=" "
        local pSymbol="${GRN}> ${R}"
    fi

    local TIME; TIME="${DGRN}$(date +%d:%H%M.%S)${R}"
    local USR="${BLU}\u${R}"
    local SEP="${GRN}:"
    local FRONT="${TIME}${leadSym}${USR}"

    if [ -n "$VIRTUAL_ENV" ]; then
        body="($(basename "$VIRTUAL_ENV"))${FRONT}${SEP}${BLU}\W"
    elif [ "$PWD" == "$HOME" ]; then
        body="${FRONT}"
    else
        body="${FRONT}${SEP}${BLU}\W"
    fi

    if git rev-parse --is-inside-work-tree &>/dev/null; then
        if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
            gitPart=$(__git_ps1 "${GRN}:${RED}%s${R}")
        else
            gitPart=$(__git_ps1 "${GRN}:${BLU}%s${R}")
        fi

        PS1="${body}${gitPart}\n${pSymbol}"
    else
        PS1="${body}\n${pSymbol}"
    fi
}
PROMPT_COMMAND=set_prompt

custom_path_add "$HOME/.config/zigvm/current"
custom_path_add "$HOME/go/bin"
custom_path_add "/usr/local/go/bin"
export EDITOR=nvim
