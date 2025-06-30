# ls variants
ls()   { eza --icons -G "$@" }
zstyle ':completion:ls:*' description 'eza (icons, color)'

lm()   { ls --sort=modified "$@" }
zstyle ':completion:lm:*' description 'ls sorted by modified time'

la()   { ls -a "$@" }
zstyle ':completion:la:*' description 'ls all (hidden files)'

lam()  { la --sort=modified "$@" }
zstyle ':completion:lam:*' description 'ls all sorted by modified time'

# ll variants
ll()   { eza -lbhHigUmuS --icons --git --color-scale --time-style=long-iso "$@" }
zstyle ':completion:ll:*' description 'eza long listing (git, color-scale, long time)'

llm()  { ll --sort=modified "$@" }
zstyle ':completion:llm:*' description 'll sorted by modified time'

lla()  { ll --all "$@" }
zstyle ':completion:lla:*' description 'll all (hidden files)'

llam() { lla --sort=modified "$@" }
zstyle ':completion:llam:*' description 'll all sorted by modified time'

# laa, lx, lxa
llaa()  { lla --all "$@" }
zstyle ':completion:laa:*' description 'eza long listing (extra mode aa)'

llx()   { ll -@ "$@" }
zstyle ':completion:lx:*' description 'eza long listing with extended attributes'

llxa()  { llx --all "$@" }
zstyle ':completion:lxa:*' description 'eza long listing with extended attributes (all)'

# misc
lS()   { eza -1 "$@" }
zstyle ':completion:lS:*' description 'eza single column'

llt()  { eza -1 --icons --tree --git "$@" }
zstyle ':completion:llt:*' description 'eza tree view'

llta() { llt --all "$@" }
zstyle ':completion:llta:*' description 'eza tree view with all files'
