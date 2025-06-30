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
autoload -Uz compinit
compinit

# 6. Plugins (turbo when possible)
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid blockf
zinit light wintermi/zsh-brew

zinit ice wait lucid blockf
zinit snippet OMZP::asdf/asdf.plugin.zsh

export ATUIN_NOBIND="true"
zinit ice wait lucid blockf
zinit light atuinsh/atuin
bindkey '^r' atuin-search

zinit wait lucid for MichaelAquilina/zsh-autoswitch-virtualenv

zinit ice wait lucid blockf
zinit light ajeetdsouza/zoxide

# fzf-tab — defer after other interactive tools
zinit ice wait lucid blockf
zinit light Aloxaf/fzf-tab
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-min-size 200 8

zinit ice wait lucid blockf
zinit light Freed-Wu/fzf-tab-source

# direnv — from GitHub releases
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

# uv
export PATH="$HOME/.local/bin:$PATH"

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

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi
