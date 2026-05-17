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

compdef _dc_services dcvol 2>/dev/null
