# Ted's Dotfiles

## Setup Directions

* Install XCode. The big one is needed to compile MacVim, so don't skimp.
* Using the system git, clone this repository. (This will most likely prompt you
  to install the command line tools)

```
git clone --recursive https://github.com/tedkulp/dotfiles.git ~/dotfiles
```

* Optionally, run the osx script. This will set a bunch of sensible Mac defaults.

```
~/dotfiles/osx
```

* Run the brew command. Make a sandwich... get a nice beverage...  maybe see if something
  is on Netflix. This will install a lot of software from source.

```
~/dotfiles/brew
```

* Now, optionally, run the cask command. This will install some nice Mac software.

```
~/dotfiles/cask
```

* Setup Dropbox and let it sync. We need the link-private directory for all our ssh and
  gnupg stuff

* After Dropbox is synced, link up the link-private directory to your dotfiles.

```
ln -s ~/Dropbox/link-private ~/dotfiles/
```

* Run the dotfiles command. This will symlink everything into place in your home
  directory.

```
~/dotfiles/dotfiles
```

## Links

* ZSH Quickstart Kit - https://github.com/unixorn/zsh-quickstart-kit
* zgen - https://github.com/tarjoilija/zgen
* Spacemacs - https://github.com/syl20bnr/spacemacs
* My VIM Config - https://github.com/tedkulp/vim-config
