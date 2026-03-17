function dcrun () {
  docker compose "$@"
}

function dclogs () {
  docker compose logs "$@"
}

function dcshell () {
  docker compose exec "$@" sh -c "[ -e /bin/bash ] && /bin/bash || [ -e /bin/zsh ] && /bin/zsh || /bin/sh"
}

function dcrestart () {
  docker compose rm -sf "$@"
  docker compose up -d "$@"
}

_dc_services() {
  local -a services
  services=(${(f)"$(docker compose config --services 2>/dev/null)"})
  _describe 'service' services
}

compdef _dc_services dcshell dcrestart dcrun dclogs
