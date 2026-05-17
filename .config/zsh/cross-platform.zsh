# Cross-platform clipboard functions
# Works on macOS, Linux (X11/Wayland), WSL, and SSH with OSC 52
if [[ "$OSTYPE" == darwin* ]]; then
  # macOS — native pbcopy/pbpaste already exist, nothing to do
  :
elif [[ -n "$WSL_DISTRO_NAME" || -n "$WSLENV" ]]; then
  # WSL — use Windows clip.exe / powershell
  function pbcopy() { clip.exe; }
  function pbpaste() { powershell.exe -NoProfile -Command Get-Clipboard | tr -d '\r'; }
elif [[ -n "$WAYLAND_DISPLAY" ]]; then
  # Wayland
  function pbcopy() { wl-copy; }
  function pbpaste() { wl-paste --no-newline; }
elif [[ -n "$DISPLAY" ]]; then
  # X11
  if (( $+commands[xclip] )); then
    function pbcopy() { xclip -selection clipboard; }
    function pbpaste() { xclip -selection clipboard -o; }
  elif (( $+commands[xsel] )); then
    function pbcopy() { xsel --clipboard --input; }
    function pbpaste() { xsel --clipboard --output; }
  else
    # Fallback: OSC 52 for copy (works over SSH in supported terminals)
    function pbcopy() {
      local data
      data=$(base64 | tr -d '\n')
      printf '\e]52;c;%s\a' "$data"
    }
    function pbpaste() {
      print -u2 "pbpaste: no clipboard tool found (install xclip or xsel)"
      return 1
    }
  fi
else
  # Headless / SSH — OSC 52 escape sequence
  # Supported by iTerm2, kitty, alacritty, tmux (set-clipboard on), etc.
  function pbcopy() {
    local data
    data=$(base64 | tr -d '\n')
    # If inside tmux, wrap in tmux passthrough
    if [[ -n "$TMUX" ]]; then
      printf '\ePtmux;\e\e]52;c;%s\a\e\\' "$data"
    else
      printf '\e]52;c;%s\a' "$data"
    fi
  }
  function pbpaste() {
    print -u2 "pbpaste: no display and no clipboard tool available"
    return 1
  }
fi

# Cross-platform "open" command
# Behaves like macOS `open` — opens files, directories, and URLs with the default handler
if [[ "$OSTYPE" == darwin* ]]; then
  # macOS — native `open` already exists
  :
elif [[ -n "$WSL_DISTRO_NAME" || -n "$WSLENV" ]]; then
  function open() {
    if [[ $# -eq 0 ]]; then
      explorer.exe .
    else
      for arg in "$@"; do
        if [[ "$arg" =~ ^https?:// ]]; then
          cmd.exe /c start "" "$arg" 2>/dev/null
        elif [[ -e "$arg" ]]; then
          wslview "$arg" 2>/dev/null || explorer.exe "$(wslpath -w "$arg")"
        else
          cmd.exe /c start "" "$arg" 2>/dev/null
        fi
      done
    fi
  }
elif (( $+commands[xdg-open] )); then
  function open() {
    if [[ $# -eq 0 ]]; then
      xdg-open .
    else
      for arg in "$@"; do
        xdg-open "$arg" &>/dev/null &disown
      done
    fi
  }
elif (( $+commands[wslview] )); then
  # wslu without the WSL env vars (edge case)
  function open() {
    if [[ $# -eq 0 ]]; then
      wslview .
    else
      for arg in "$@"; do
        wslview "$arg"
      done
    fi
  }
else
  function open() {
    print -u2 "open: no handler found (install xdg-utils)"
    return 1
  }
fi
