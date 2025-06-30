# alias cd=z
cd() {
  if whence -w z >/dev/null 2>&1; then # Does a command called 'z' exist right now?
    z "$@"                             # use it
  else
    builtin cd "$@"                    # quiet fallback
  fi
}
