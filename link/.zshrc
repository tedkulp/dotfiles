#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

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
