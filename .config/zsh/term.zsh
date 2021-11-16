# If we're not in tmux, make sure we're in xterm-256color
[[ ! -n $TMUX ]] && export TERM="xterm-256color"

# Some terminals like to set erase to ^H. Override it.
stty -g | grep "erase=8" > /dev/null
if [[ $? == 0 ]]; then
  stty erase '^?'
fi
