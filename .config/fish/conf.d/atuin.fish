if status is-interactive
    set -gx ATUIN_NOBIND true
    atuin init fish | source

    bind \cr _atuin_search
    bind \e\[1\;5A _atuin_bind_up # ctrl-up
end
