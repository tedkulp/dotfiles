alias dcrun="docker compose "
alias dclogs="docker compose logs "

function dcrestart () {
  docker compose rm -sf "$@"
  docker compose up -d "$@"
}
