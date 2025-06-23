# Aliases
alias xssh="xpanes --ssh"
alias tmux="tmux -2"

# Function to get the current TMUX session
_tm_get_current_session() {
    tmux display-message -p '#S'
}

# Function to attach or switch to a TMUX session
tm() {
    local targetSession="${1:-main}"

    # If outside tmux, start a new session or attach
    if [[ -z "$TMUX" ]]; then
        tmux new -A -s "$targetSession"
        return $?
    fi

    # If already in the target session, return
    if [[ "$(_tm_get_current_session)" == "$targetSession" ]]; then
        echo "You did not move."
        return 1
    fi

    # Create session if it doesn't exist
    tmux new -d -s "$targetSession" 2>/dev/null

    # Switch to the target session
    tmux switch-client -t "$targetSession"
}

# Function to complete tmux session names
_tm() {
    local tmuxList
    tmuxList=($(tmux ls -F "#{session_name}" 2>/dev/null))

    # If outside tmux, complete with session list
    if [[ -z "$TMUX" ]]; then
        for session in "${tmuxList[@]}"; do
            echo "$session"
        done
        return 0
    fi

    local currentSession actualList=()
    currentSession="$(_tm_get_current_session)"

    # Exclude the current session from the list
    for session in "${tmuxList[@]}"; do
        if [[ "$session" != "$currentSession" ]]; then
            actualList+=("$session")
        fi
    done

    for session in "${actualList[@]}"; do
        echo "$session"
    done
}

# Register the function for tab completion
if (( $+functions[compdef] )); then
    compdef '_tm' tm
fi