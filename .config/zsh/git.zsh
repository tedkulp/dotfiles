alias ghm='git push heroku master'
alias gpp='git pull origin "(git_current_branch)" && git push origin "(git_current_branch)"'

function grcl () {
    local branch="${1:-master}"

    echo git checkout $branch
    echo git pull
    echo git remote prune origin
    echo git branch -avv | grep "gone]" | awk '{ print $1 }' | xargs git branch -d;
}

alias gie='git init && git commit --allow-empty -m "Initial commit"'

# alias __git-checkout_main=_git_checkout
# compdef _git grcl=git-checkout

alias grc="git branch --merged | grep -v '\*' | grep -v master | grep -v stage | xargs -n 1 git branch -d"
alias grcr="git fetch --all -p && git branch -r --merged | grep -v '\*' | grep origin | grep -v master | grep -v stage | sed 's/origin\//:/' | xargs -n 1 echo git push origin"
