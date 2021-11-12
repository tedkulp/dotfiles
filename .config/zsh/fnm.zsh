export PATH=/home/ted/.fnm:$PATH
eval "`fnm env`"

autoload -U add-zsh-hook
_fnm_autoload_hook () {
    if [[ -f .node-version || -f .nvmrc ]]; then
        fnm use --install-if-missing
    fi
}

add-zsh-hook chpwd _fnm_autoload_hook \
    && _fnm_autoload_hook

alias nvm="fnm"
