function p () {
  local pager="$PAGER"

  if [ -n "$pager" ]; then
    if command -v "$pager" &>/dev/null; then
      $PAGER "$@"
    fi
  else
    if command -v less &>/dev/null; then
      less -R "$@"
    else
      cat "$@"
    fi
  fi
}

alias pl="p -l"
alias jqp="jq . | p -l json"
alias yqp="yq . | p -l yaml"
