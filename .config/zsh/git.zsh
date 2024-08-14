alias ghm='git push heroku master'
alias gpp='git pull origin "(git_current_branch)" && git push origin "(git_current_branch)"'
alias gfap='git pull --all -p'
alias ly='lazygit --use-config-file "$HOME/.config/yadm/lazygit.yml,$HOME/Library/Application Support/lazygit/config.yml" --work-tree ~ --git-dir ~/.local/share/yadm/repo.git'

function gctest () {
  local branch="${1:-master}"

  git merge --no-commit --no-ff $1
  git merge --abort
}

function grcl () {
    local branch="${1:-master}"

    git checkout $branch
    gfap
    git remote prune origin
    git branch -avv | grep "gone]" | awk '{ print $1 }' | xargs git branch -d;
}

unset gie
function gie () {
  local email="${1:-ted@tedkulp.com}"

  git init
  git config user.email "$email"
  git commit --allow-empty -m "Initial Commit"
}

# alias gie='git init && git commit --allow-empty -m "Initial commit"'

# alias __git-checkout_main=_git_checkout
# compdef _git grcl=git-checkout

alias grc="git branch --merged | grep -v '\*' | grep -v master | grep -v stage | xargs -n 1 git branch -d"
alias grcr="git fetch --all -p && git branch -r --merged | grep -v '\*' | grep origin | grep -v master | grep -v stage | sed 's/origin\//:/' | xargs -n 1 echo git push origin"

alias lg="lazygit"

krak () {
    dir="$(cd "$(dirname "$1")"; pwd -P)/$(basename "$1")"
    open gitkraken://repo/$dir
}
