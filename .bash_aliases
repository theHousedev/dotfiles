alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ..l='cd .. && ll'
alias ...l='cd ../.. && ll'
alias ....l='cd ../../.. && ll'
alias f='find . | grep '
alias h='history | grep '

alias gp="git push"
alias gs="git status"
alias pg="git pull origin "
alias log="git log -10 --oneline --graph"
alias log20="git log -20 --oneline --graph"
alias log40="git log -40 --oneline --graph"

alias rc.nvim="nvim $HOME/.bashrc"
alias config.nvim="nvim $HOME/.config/nvim/"
alias aliases.nvim="nvim $HOME/.bash_aliases"
alias options.nvim="nvim $HOME/.config/nvim/lua/options.lua"
alias keybinds.nvim="nvim $HOME/.config/nvim/lua/keymaps.lua"

alias cd.cfg.nvim="cd $HOME/.config/nvim/"
alias cd.options.nvim="cd $HOME/.config/nvim/lua/ && nvim options.lua"
alias cd.keybinds.nvim="cd $HOME/.config/nvim/lua/ && nvim keymaps.lua"

hasCmd() {
    if command -v "$1" &>/dev/null; then
        return 0
    else
        return 1
    fi
}

if hasCmd "pydf"; then
    alias df='pydf'
else
    echo "Command 'pydf' unavailable: check ~./bash_aliases"
fi

if hasCmd "lsd"; then
    alias l='lsd -F --group-directories-first'
    alias ls='lsd -F --group-directories-first'
    alias la='lsd -FA --total-size --group-directories-first'
    alias ll='lsd -lF --total-size --group-directories-first'
    alias lal='lsd -lFA --total-size --group-directories-first'
else
    echo "Command 'lsd' unavailable: check ~./bash_aliases"
fi

