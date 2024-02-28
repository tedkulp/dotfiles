alias xssh="xpanes --ssh"
alias tmux="tmux -2"

_tm.getCurrenSession() tmux display-message -p '#S'

tm() {
  local targetSession=${1:='main'}

  # if outside tmux
  [[ -z "$TMUX" ]] && tmux new -A -s ${targetSession} && return $?

  if [[ "`_tm.getCurrenSession`" = "$targetSession" ]]
    then print "You did not move."; return 1
  fi

  # Create session if it doesn't exists
  tmux new -d -s ${targetSession} 2>/dev/null

  tmux switch-client -t ${targetSession}
}

_tm() {
  (( $CURRENT > 2 )) && return 0

  local tmuxList=( `tmux ls -F "#{session_name}"` )

  # if outside tmux
  [[ -z "$TMUX" ]] &&  _describe 'command' tmuxList && return 0

  local currentSession=( `_tm.getCurrenSession` )
  local actualList=(${tmuxList:|currentSession})
  _describe 'command' actualList
}

compdef _tm tm
