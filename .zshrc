# **1. Instant Prompt – MUST be first**
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi

# 2. Load Zinit
source "${HOME}/.local/share/zinit/zinit.git/zinit.zsh"

export ZSH_CUSTOM=$HOME/.config/zsh

# 3. Load Powerlevel10k — do NOT use ice wait or turbo on it
zinit ice depth=1 lucid nocd
zinit light romkatv/powerlevel10k

# 4. Source your p10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 5. Initialize completions early (needed for proper tab completion)
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zinit ice as'program' id-as'carapace' from'gh-r' atload' \
  autoload -Uz compinit; \
  compinit; \
  source <(carapace _carapace);'
zinit light carapace-sh/carapace-bin

# zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'

# 6. Plugins (turbo when possible)
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid blockf
zinit light wintermi/zsh-brew

zinit ice wait lucid blockf
zinit snippet OMZP::asdf/asdf.plugin.zsh

# mmv renamer
zinit ice lucid wait'0' as'program' id-as'mmv' from'gh-r' \
  mv'mmv* -> mmv' pick'mmv/mmv'
zinit light 'itchyny/mmv'

export ATUIN_NOBIND="true"
zinit ice wait lucid blockf
zinit light atuinsh/atuin
bindkey '^r' atuin-search

# uv
zinit ice wait lucid blockf
zinit load matthiasha/zsh-uv-env
export PATH="$HOME/.local/bin:$PATH"

# zoxide
zinit ice wait lucid blockf
zinit light ajeetdsouza/zoxide

if [[ "${TERM_PROGRAM}" == "tmux" ]]; then
  # fzf-tab — defer after other interactive tools
  zinit ice wait lucid blockf
  zinit light Aloxaf/fzf-tab
  zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
  zstyle ':fzf-tab:*' popup-min-size 200 8
  zstyle ':fzf-tab:*' query-string ''
fi

# # direnv — from GitHub releases
zinit from"gh-r" as"program" mv"direnv* -> direnv" \
    atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
    pick"direnv" src="zhook.zsh" for \
        direnv/direnv

# 7. Syntax highlighting — fast and light
zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

# 8. Completions (keep blockf, no wait!)
zi for \
    blockf \
    lucid \
    zsh-users/zsh-completions

# 9. Load all custom configs from $ZSH_CUSTOM
for config_file ("$ZSH_CUSTOM"/*.zsh(N)); do
  source "$config_file"
done
unset config_file

# 10. Custom functions/aliases
function timezsh() {
  for i in {1..5}; do /usr/bin/time -p zsh -i -c exit; done
}
### End of Zinit's installer chunk

# Shell-GPT integration ZSH v0.2
_sgpt_zsh() {
if [[ -n "$BUFFER" ]]; then
    _sgpt_prev_cmd=$BUFFER
    BUFFER+="⌛"
    zle -I && zle redisplay
    BUFFER=$(sgpt --shell <<< "$_sgpt_prev_cmd" --no-interaction)
    zle end-of-line
fi
}
zle -N _sgpt_zsh
bindkey ^p _sgpt_zsh
# Shell-GPT integration ZSH v0.2

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi
