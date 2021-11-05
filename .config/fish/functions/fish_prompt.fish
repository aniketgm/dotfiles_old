#              __________________ 
#          /\  \   __           /  /\    /\           Author      : Aniket Meshram [AniGMe]
#         /  \  \  \         __/  /  \  /  \          Description : This file sets the fish prompt. All other
#        /    \  \       _____   /    \/    \                       prompt functions are called from here.
#       /  /\  \  \     /    /  /            \                      This is customized on top of Hydro Prompt.
#      /        \  \        /  /      \/      \                     https://github.com/jorgebucaran/hydro
#     /          \  \      /  /                \
#    /            \  \    /  /                  \     Github Repo : https://github.com/aniketgm/dotfiles
#   /              \  \  /  /                    \
#  /__            __\  \/  /__                  __\
#

function fish_prompt -d 'Customized Hydro Prompt'

    # Set symbol before _hydro_pwd
    if set -q ConEmuIsAdmin || fish_is_root_user
        set _hydro_preprompt_symbol ' Ψ '
    else
        set _hydro_preprompt_symbol ' λ '
    end

    # Add current time to prompt
    set _hydro_time '['(date +%H:%M)']'
    # Change _hydro_pwd to basename only
    set _hydro_pwd (basename (prompt_pwd))
    # Set symbol after prompt
    set _hydro_prompt '››'

    # Add colors to prompt
    set -l rand_colors F44336 E91E63 9C27B0 673AB7 3F51B5 2196F3 03A9F4 00BCD4 009688 4CAF50 8BC34A CDDC39 FFEB3B FFC107 FF9800 FF5722 EF9A9A  81D4FA D32F2F C2185B 7B1FA2 512DA8 303F9F 1976D2 0288D1 0097A7 00796B 388E3C 689F38 AFB42B FBC02D FFA000 F57C00 E64A19 5D4037 616161 455A64
    set -l rand_color_idx (math (random) \% 36 + 1)
    set_color -o $rand_colors[$rand_color_idx]
    string unescape "$_hydro_color_pwd$_hydro_time$_hydro_preprompt_symbol$_hydro_pwd\x1b[0m $_hydro_color_git$$_hydro_git\x1b[0m$_hydro_color_duration$_hydro_cmd_duration\x1b[0m$_hydro_prompt\x1b[0m "
end
