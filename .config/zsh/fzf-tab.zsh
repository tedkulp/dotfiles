# https://github.com/Aloxaf/fzf-tab?tab=readme-ov-file#fzf-tab

zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' fzf-command 'fzf-tmux'
zstyle ':fzf-tab:*' fzf-flags '-p 75%'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'

LESSOPEN="|/opt/homebrew/bin/lesspipe.sh %s"; export LESSOPEN
