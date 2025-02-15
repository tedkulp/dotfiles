function p
    set -l pager $PAGER

    if test -n "$pager"
        if command -v "$pager" &>/dev/null
            env BAT_STYLE=grid,numbers,snip,changes $pager $argv
        end
    else
        if command -v less &>/dev/null
            less -R $argv
        else
            cat $argv
        end
    end
end

alias pl="p -l"
# alias jqp="jq . | p -l json"
#alias yqp="yq . | p -l yaml"
alias pjq="jq . | p -l json"
alias pyq="yq . | p -l yaml"
