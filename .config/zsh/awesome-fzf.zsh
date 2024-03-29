AWESOME_FZF_LOCATION="$HOME/.config/zsh/awesome-fzf.zsh"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

#List Awesome FZF Functions
function fzf-awesome-list() {
if [[ -f $AWESOME_FZF_LOCATION ]]; then
    selected=$(grep -E "(function fzf-)(.*?)[^(]*" $AWESOME_FZF_LOCATION | sed -e "s/function fzf-//" | sed -e "s/() {//" | grep -v "selected=" | fzf-tmux --reverse --prompt="awesome fzf functions > ")
else
    echo "awesome fzf not found"
fi
    case "$selected" in
        "");; #don't throw an exit error when we dont select anything
        *) "fzf-"$selected;;
    esac
}


#Enhanced rm
function fzf-rm() {
  if [[ "$#" -eq 0 ]]; then
    local files
    files=$(find . -maxdepth 1 -type f | fzf-tmux --multi)
    echo $files | xargs -I '{}' rm {} #we use xargs so that filenames to capture filenames with spaces in them properly
  else
    command rm "$@"
  fi
}

# Man without options will use fzf to select a page
function fzf-man() {
	MAN="/usr/bin/man"
	if [ -n "$1" ]; then
		$MAN "$@"
		return $?
	else
		$MAN -k . | fzf-tmux --reverse --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | xargs $MAN" | awk '{print $1 "." $2}' | tr -d '()' | xargs -r $MAN
		return $?
	fi
}


#Eval commands on the fly
function fzf-eval() {
echo | fzf-tmux -q "$*" --preview-window=up:99% --preview="eval {q}"
}

## Search list of your aliases and functions
function fzf-aliases-functions() {
    CMD=$(
        (
            (alias)
            (functions | grep "()" | cut -d ' ' -f1 | grep -v "^_" )
        ) | fzf-tmux | cut -d '=' -f1
    );

    eval $CMD
}


## File Finder (Open in $EDITOR)
function fzf-find-files() {
  local file=$(fzf-tmux --multi --reverse) #get file from fzf
  if [[ $file ]]; then
    for prog in $(echo $file); #open all the selected files
    do; $EDITOR $prog; done;
  else
    echo "cancelled fzf"
  fi
}



# Find Dirs
function fzf-cd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf-tmux +m) &&
  cd "$dir"
  ls
}

# Find Dirs + Hidden
function fzf-cd-incl-hidden() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf-tmux +m) && cd "$dir"
  ls
}

# cd into the directory of the selected file
function fzf-cd-to-file() {
   local file
   local dir
   file=$(fzf-tmux +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
   ls
}

# fdr - cd to selected parent directory
function fzf-cd-to-parent() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  cd "$DIR"
  ls
}

# Search env variables
function fzf-env-vars() {
  local out
  out=$(env | fzf)
  echo $(echo $out | cut -d= -f2)
}


# Kill process
function fzf-kill-processes() {
  local pid
  pid=$(ps -ef | sed 1d | fzf-tmux -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# Enhanced Git Status (Open multiple files with tab + diff preview)
fzf-git-status() {
    git rev-parse --git-dir > /dev/null 2>&1 || { echo "You are not in a git repository" && return }
    local selected
    selected=$(git -c color.status=always status --short |
        fzf-tmux --height 50% "$@" --border -m --ansi --nth 2..,.. \
        --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
        cut -c4- | sed 's/.* -> //')
            if [[ $selected ]]; then
                for prog in $(echo $selected);
                do; $EDITOR $prog; done;
            fi
    }

# Checkout to existing branch or else create new branch. gco <branch-name>.
# Falls back to fuzzy branch selector list powered by fzf if no args.
fzf-checkout(){
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ "$#" -eq 0 ]]; then
            local branches branch
            branches=$(git branch -a) &&
            branch=$(echo "$branches" |
            fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
            git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
        elif [ `git rev-parse --verify --quiet $*` ] || \
             [ `git branch --remotes | grep  --extended-regexp "^[[:space:]]+origin/${*}$"` ]; then
            echo "Checking out to existing branch"
            git checkout "$*"
        else
            echo "Creating new branch"
            git checkout -b "$*"
        fi
    else
        echo "Can't check out or create branch. Not in a git repo"
    fi
}
