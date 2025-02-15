set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME $HOME/.config

set -q FZF_TMUX; or set -gx FZF_TMUX 1

# disable default greeting
set fish_greeting

# Fisher!
if not functions -q fisher
    echo "==> Fisherman not found.  Installing."
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    source $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fisher update
    tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time='24-hour format' --rainbow_prompt_separators=Slanted --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='Two lines, character and frame' --prompt_connection=Dotted --powerline_right_prompt_frame=No --prompt_connection_andor_frame_color=Darkest --prompt_spacing=Sparse --icons='Many icons' --transient=No
end


# uv
fish_add_path "/Users/tedkulp/.local/bin"
