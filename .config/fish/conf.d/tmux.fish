# Aliases
alias xssh "xpanes --ssh"
alias tmux "tmux -2"

# Function to get the current TMUX session
function _tm_get_current_session
    tmux display-message -p '#S'
end

# Function to attach or switch to a TMUX session
function tm
    set -l targetSession (test -n "$argv[1]"; and echo "$argv[1]"; or echo "main")

    # If outside tmux, start a new session or attach
    if not set -q TMUX
        tmux new -A -s $targetSession
        return $status
    end

    # If already in the target session, return
    if test (_tm_get_current_session) = "$targetSession"
        echo "You did not move."
        return 1
    end

    # Create session if it doesn't exist
    tmux new -d -s $targetSession 2>/dev/null

    # Switch to the target session
    tmux switch-client -t $targetSession
end

# Function to complete tmux session names
function _tm
    set -l tmuxList (tmux ls -F "#{session_name}" 2>/dev/null)

    # If outside tmux, complete with session list
    if not set -q TMUX
        for session in $tmuxList
            echo $session
        end
        return 0
    end

    set -l currentSession (_tm_get_current_session)
    set -l actualList

    # Exclude the current session from the list
    for session in $tmuxList
        if test "$session" != "$currentSession"
            set actualList $actualList $session
        end
    end

    for session in $actualList
        echo $session
    end
end

# Register the function for tab completion
complete -c tm -a "(_tm)"
