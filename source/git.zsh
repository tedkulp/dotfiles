alias ghm='git push heroku master'
alias gpp='git pull origin "$(git_current_branch)" && git push origin "$(git_current_branch)"'

function grcl () {
  local branch="${1:=master}"

  git checkout $branch
  git pull
  git remote prune origin
  git branch -avv | grep "gone]" | awk '{ print $1 }' | xargs git branch -d;
}
alias __git-checkout_main=_git_checkout
compdef _git grcl=git-checkout

# For "hub" http://hub.github.com/
# eval "$(hub alias -s)"
