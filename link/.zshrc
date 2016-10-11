#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
# if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
#   source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
# fi

# Source antigen
source $(brew --prefix)/share/antigen/antigen.zsh
source ~/.antigen.zsh

# Run all files in dotfiles source directory
if [[ -d "$HOME/dotfiles/source" ]]; then
  if [ "$(ls -A $HOME/dotfiles/source)" ]; then
    for file in ~/dotfiles/source/*; do
      source "$file"
    done
  fi
fi

# Run all files in local source directory
if [[ -d "$HOME/source" ]]; then
  if [ "$(ls -A $HOME/source)" ]; then
    for file in $HOME/source/*; do
      source "$file"
    done
  fi
fi

# Customize to your needs...

export NVM_DIR="/Users/tedkulp/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# setopt no_complete_aliases

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

export HOMEBREW_GITHUB_API_TOKEN=80ad9e8581e2506efeaedaa079ae02b50add8821
