# Aliases
alias dcrun "docker compose"
alias dclogs "docker compose logs"

# Function to enter a shell in a Docker container
function dcshell
    docker compose exec $argv sh -c "[ -e /bin/bash ] && /bin/bash || [ -e /bin/zsh ] && /bin/zsh || /bin/sh"
end

# Function to restart a Docker container
function dcrestart
    docker compose rm -sf $argv
    docker compose up -d $argv
end
