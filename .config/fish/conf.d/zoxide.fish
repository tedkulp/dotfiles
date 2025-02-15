if status is-interactive
    zoxide init fish | source
    function cd --wraps=z --description 'alias cd z'
        z $argv
    end
end
