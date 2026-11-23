# Docker Compose helpers. They act on, in order:
#   1. $DC_DIR, if set
#   2. the current directory, if it has a compose file
#   3. /opt/docker-compose, where Ansible deploys each server's stack
#   4. the current directory (plain `docker compose` lookup)
# Laptops have no /opt/docker-compose, so they get 2 or 4.
_DC_SERVER_DIR=/opt/docker-compose
_DC_FILES=(compose.yaml compose.yml docker-compose.yaml docker-compose.yml)

# Prints the directory to use, or nothing for plain compose lookup.
_dc_dir() {
  local f
  if [[ -n $DC_DIR ]]; then print -r -- "$DC_DIR"; return; fi
  for f in $_DC_FILES; do [[ -f $f ]] && { print -r -- "$PWD"; return; }; done
  [[ -f $_DC_SERVER_DIR/docker-compose.yml ]] && print -r -- "$_DC_SERVER_DIR"
}

# Compose file inside the chosen directory.
_dc_file() {
  local d=${$(_dc_dir):-$PWD} f
  for f in $_DC_FILES; do [[ -f $d/$f ]] && { print -r -- "$d/$f"; return; }; done
  print -r -- "$d/docker-compose.yml"
}

_dc() {
  local d=$(_dc_dir)
  if [[ -n $d ]]; then
    docker compose -f "$(_dc_file)" --project-directory "$d" "$@"
  else
    docker compose "$@"
  fi
}

dcrun()     { _dc "$@"; }
dcrunnopd() { docker compose -f "$(_dc_file)" "$@"; }   # no --project-directory
dclogs()    { _dc logs "$@"; }
dcssh()     { _dc exec "$@"; }
dcrestart() { _dc rm -fs "$@" && _dc up --remove-orphans -d "$@"; }
dcbash()    { _dc exec "$@" sh -c 'exec $(command -v bash || command -v ash || command -v sh)'; }
dcsh()      { dcbash "$@"; }
dcshell()   { dcbash "$@"; }
dcedit()    { "${EDITOR:-nvim}" "$(_dc_file)"; }
dcenv()     { "${EDITOR:-nvim}" "${$(_dc_dir):-$PWD}/.env"; }
dccd()      { cd "${$(_dc_dir):-$PWD}"; }
dcupdate()  { cd "${$(_dc_dir):-$PWD}" && dc-update --show-warnings=true "$@"; }

# dc-update (github:tedkulp/dc-update via mise) reads ./docker-compose.yml
# unless given -f.
dc-update() {
  local d=$(_dc_dir)
  if [[ -n $d && $d != $PWD ]]; then
    command dc-update -f "$(_dc_file)" "$@"
  else
    command dc-update "$@"
  fi
}

alias dclogsize="docker inspect --format='{{.LogPath}}' \$(docker ps -a -q) | sudo xargs -n 1 du -ah | sort -h"
alias dclogtotal="docker inspect --format='{{.LogPath}}' \$(docker ps -a -q) | sudo xargs -n 1 du -ab | awk '{ sum += \$1 } END { print sum }' | numfmt --to=si"

_dc_services() {
  local -a services
  services=(${(f)"$(_dc config --services 2>/dev/null)"})
  _describe 'service' services
}

_dc_running_services() {
  local -a services
  services=(${(f)"$(_dc ps --services 2>/dev/null)"})
  _describe 'running service' services
}

compdef _dc_services dcrun dcrunnopd dclogs dcssh dcrestart dcupdate dc-update
compdef _dc_running_services dcbash dcsh dcshell

# dcvol - drop into a shell inside a docker volume with the right permissions
# Usage: dcvol [-i image] [-r] <container> [volume]
dcvol() {
    emulate -L zsh
    setopt local_options err_return pipe_fail

    local image="" as_root=0
    local OPTIND opt
    while getopts "i:rh" opt; do
        case $opt in
            i) image="$OPTARG" ;;
            r) as_root=1 ;;
            h|*)
                cat <<'EOF'
Usage: dcvol [-i image] [-r] <container> [volume]

Drops you into a shell with access to a volume used by <container>.
The shell runs as the same user the container runs as, so permissions match.

If [volume] is omitted, lists the container's mounts and prompts.

Options:
  -i IMAGE    Image to use for the shell (default: same as target container)
  -r          Run as root instead of the container's user
  -h          Show this help

Examples:
  dcvol my-postgres
  dcvol my-postgres pgdata
  dcvol -r my-postgres pgdata
EOF
                [[ $opt == h ]] && return 0 || return 1
                ;;
        esac
    done
    shift $((OPTIND - 1))

    if (( $# < 1 )); then
        echo "Usage: dcvol [-i image] [-r] <container> [volume]" >&2
        return 1
    fi

    local container="$1" volume="${2:-}"

    if ! docker inspect "$container" >/dev/null 2>&1; then
        echo "Error: container '$container' not found" >&2
        return 1
    fi

    # Get mounts as TSV: type<TAB>name<TAB>source<TAB>destination
    local mounts
    mounts=$(docker inspect "$container" --format \
        $'{{range .Mounts}}{{.Type}}\t{{.Name}}\t{{.Source}}\t{{.Destination}}\n{{end}}')

    if [[ -z "$volume" ]]; then
        echo "Mounts in $container:"
        echo "$mounts" | awk -F'\t' 'NF>=4 {printf "  %-10s %-30s -> %s\n", $1, ($2==""?"(bind)":$2), $4}'
        echo
        read "volume?Volume or mount destination: "
    fi

    local mount_line
    mount_line=$(echo "$mounts" | awk -F'\t' -v v="$volume" '$2 == v || $4 == v {print; exit}')

    if [[ -z "$mount_line" ]]; then
        echo "Error: no mount matching '$volume' found in $container" >&2
        echo "Available mounts:" >&2
        echo "$mounts" | awk -F'\t' 'NF>=4 {printf "  %s -> %s\n", ($2==""?$3:$2), $4}' >&2
        return 1
    fi

    local mount_type mount_name mount_source mount_dest
    mount_type=${mount_line%%$'\t'*}
    local rest=${mount_line#*$'\t'}
    mount_name=${rest%%$'\t'*}
    rest=${rest#*$'\t'}
    mount_source=${rest%%$'\t'*}
    mount_dest=${rest#*$'\t'}

    [[ -z "$image" ]] && image=$(docker inspect "$container" --format '{{.Config.Image}}')

    local -a user_flag
    local container_user=""
    if (( ! as_root )); then
        container_user=$(docker inspect "$container" --format '{{.Config.User}}')
        [[ -n "$container_user" ]] && user_flag=(--user "$container_user")
    fi

    local mount_arg
    if [[ "$mount_type" == "volume" ]]; then
        mount_arg="type=volume,source=$mount_name,target=$mount_dest"
    else
        mount_arg="type=bind,source=$mount_source,target=$mount_dest"
    fi

    echo "Container: $container"
    echo "Mount:     ${mount_name:-$mount_source} ($mount_type) -> $mount_dest"
    echo "Image:     $image"
    echo "User:      $( (( as_root )) && echo root || echo "${container_user:-default}" )"
    echo

    docker run --rm -it \
        $user_flag \
        --mount "$mount_arg" \
        --workdir "$mount_dest" \
        --entrypoint "" \
        "$image" \
        sh -c 'command -v bash >/dev/null && exec bash || exec sh'
}

_dcvol() {
  local state line
  _arguments \
    '-i[image for the shell]:image:->images' \
    '-r[run as root]' \
    '-h[help]' \
    '1:container:->containers' \
    '2:volume or mount destination:->mounts'
  case $state in
    images) compadd -- ${(f)"$(docker images --format '{{.Repository}}:{{.Tag}}' 2>/dev/null | grep -v '<none>')"} ;;
    containers) compadd -- ${(f)"$(docker ps -a --format '{{.Names}}' 2>/dev/null)"} ;;
    mounts) compadd -- ${=$(docker inspect "${line[1]}" --format '{{range .Mounts}}{{if .Name}}{{.Name}} {{end}}{{.Destination}} {{end}}' 2>/dev/null)} ;;
  esac
}
compdef _dcvol dcvol
