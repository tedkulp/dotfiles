if [[ -f "/usr/local/bin/gcc-12" ]]; then # Mac Hack for building vim modules
  alias vim="CC=/usr/local/bin/gcc-12 nvim"
  alias vi="CC=/usr/local/bin/gcc-12 nvim"
else
  alias vim="nvim"
  alias vi="nvim"
fi

export EDITOR="nvim"
