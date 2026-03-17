# **1. Instant Prompt – MUST be first**
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi

# 2. Load Zinit
source "${HOME}/.local/share/zinit/zinit.git/zinit.zsh"

autoload -Uz compinit
zicompinit

bindkey -e
export ZSH_CUSTOM=$HOME/.config/zsh

# 3. Load Powerlevel10k — do NOT use ice wait or turbo on it
zinit ice depth=1 lucid nocd
zinit light romkatv/powerlevel10k

# 4. Source your p10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 5. Plugins (turbo when possible)
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit light wintermi/zsh-brew

zinit as="command" lucid from="gh-r" for \
    id-as="usage" \
    atpull="%atclone" \
    jdx/usage

zinit as="command" lucid from="gh-r" for \
    id-as="mise" mv="mise* -> mise" \
    atclone="./mise* completion zsh > _mise" \
    atpull="%atclone" \
    atload='eval "$(mise activate zsh)"' \
    jdx/mise

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

# direnv — from GitHub releases
zinit from"gh-r" as"program" mv"direnv* -> direnv" \
    atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
    pick"direnv" src="zhook.zsh" for \
        direnv/direnv

# 6. Syntax highlighting — fast and light
zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

# 7. Completions (keep blockf, no wait!)
zi for \
    blockf \
    lucid \
    zsh-users/zsh-completions

zicdreplay

# 8. Load all custom configs from $ZSH_CUSTOM
for config_file ("$ZSH_CUSTOM"/*.zsh(N)); do
  source "$config_file"
done
unset config_file

# 9. Custom functions/aliases
function timezsh() {
  for i in {1..5}; do /usr/bin/time -p zsh -i -c exit; done
}

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

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi

# 10. PATH additions
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:~/.kube/plugins/jordanwilson230

# 11. Aliases
alias sc='tmux-chooser'
alias claude-mem='bun "/Users/tedkulp/.claude/plugins/cache/thedotmack/claude-mem/10.5.5/scripts/worker-service.cjs"'
