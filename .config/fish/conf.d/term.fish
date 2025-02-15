# If we're not in tmux, make sure we're in xterm-256color
if not set -q TMUX
    set -gx TERM xterm-256color
end

# Some terminals like to set erase to ^H. Override it.
if status is-interactive
    if stty -g | grep -q "erase=8"
        stty erase '^?'
    end
end
