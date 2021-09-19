function ssht () {
    ssh $1 -t "tmux attach -d || tmux"
}
