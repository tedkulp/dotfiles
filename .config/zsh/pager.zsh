function p () {
  local pager="$PAGER"

  if [ -n "$pager" ]; then
    if command -v "$pager" &>/dev/null; then
      BAT_STYLE=grid,numbers,snip,changes $PAGER "$@"
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
# alias jqp="jq . | p -l json"
#alias yqp="yq . | p -l yaml"
alias pjq="jq . | p -l json"
alias pyq="yq . | p -l yaml"
