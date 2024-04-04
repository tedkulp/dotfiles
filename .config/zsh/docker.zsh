alias dcrun="docker compose "
alias dclogs="docker compose logs "

function dcshell () {
  docker compose exec "$@" sh -c "[ -e /bin/bash ] && /bin/bash || [ -e /bin/zsh ] && /bin/zsh || /bin/sh"
}

function dcrestart () {
  docker compose rm -sf "$@"
  docker compose up -d "$@"
}
