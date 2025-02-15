alias hbu="brew outdated 2> /dev/null | sort | fzf --no-sort --height 50% --header 'Homebrew Upgrade' --reverse -m --border --preview 'sleep 1 && brew info {}' | xargs -I '{}' brew upgrade {}"
alias hbx="brew list 2> /dev/null | sort | fzf --no-sort --height 50% --header 'Homebrew Uninstall' --reverse -m --border --preview 'sleep 1 && brew info {}' | xargs -I '{}' brew uninstall {}"
alias hbi="brew list 2> /dev/null | sort | fzf --no-sort --height 50% --header 'Homebrew Installed Packages' --reverse -m --border --preview 'sleep 1 && brew info {}'"
