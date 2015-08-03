alias ghm='git push heroku master'

function grcl () {
  local branch="${1:=master}"

  git checkout $branch
  git pull
  git remote prune origin
  git branch -avv | grep "gone]" | awk '{ print $1 }' | xargs git branch -d;
}

compdef _git grcl=git-checkout

# For "hub" http://hub.github.com/
# eval "$(hub alias -s)"
