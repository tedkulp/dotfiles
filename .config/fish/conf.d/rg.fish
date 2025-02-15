set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/config

alias r="rg"
alias ri="r --ignore-case"
alias ra="r --no-ignore"
alias rA="r --hidden --no-ignore"
alias ria="r --no-ignore --ignore-case"
alias riA="r --hidden --no-ignore --ignore-case"
