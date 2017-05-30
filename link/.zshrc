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
# source $(brew --prefix)/share/antigen/antigen.zsh
# source ~/.antigen.zsh

# load zgen
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  # specify plugins here
  zgen oh-my-zsh

  # generate the init script from plugins above
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/command-not-found

  zgen load https://gist.github.com/3750104.git agnoster

  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-history-substring-search
  zgen load zsh-users/zsh-autosuggestions

  zgen oh-my-zsh plugins/brew
  zgen oh-my-zsh plugins/osx

  zgen save
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

export NVM_DIR="/Users/tedkulp/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"  # This loads nvm

# setopt no_complete_aliases

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
