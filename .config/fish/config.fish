#              __________________ 
#          /\  \   __           /  /\    /\           Author      : Aniket Meshram [AniGMe]
#         /  \  \  \         __/  /  \  /  \          Description : This is the fish shell configurations file
#        /    \  \       _____   /    \/    \                       that contains other fish configurations
#       /  /\  \  \     /    /  /            \                      like abbreviations, functions, etc.
#      /        \  \        /  /      \/      \
#     /          \  \      /  /                \      Github Repo : https://github.com/aniketgm/dotfiles
#    /            \  \    /  /                  \
#   /              \  \  /  /                    \
#  /__            __\  \/  /__                  __\
#

#set fish_greeting (fortune | cowsay -f tux)
set PATH '/home/Aniket/bin' $PATH
set -x WINHOME '/cygdrive/c/Users/Aniket'
set -x BROWSER '/home/Aniket/bin/opera'
set -x WINDSUM '/cygdrive/d/SummuData'

# --- Abbreviations ---

# Learning directory abbreviations
abbr cds 'cd /cygdrive/d/SummuData'
abbr cdl 'cd /cygdrive/d/SummuData/Learning'
abbr cgo 'cd /cygdrive/d/SummuData/Learning/Go'
abbr cja 'cd /cygdrive/d/SummuData/Learning/JavaScript'
abbr cpy 'cd /cygdrive/d/SummuData/Learning/Python'
abbr cmb 'cd /cygdrive/d/SummuData/Learning/Python/Flask/microblog'
abbr cwb 'cd /cygdrive/d/SummuData/Learning/WebDevelopment'
abbr cgh 'cd /cygdrive/d/SummuData/Learning/GithubRepos'

# Other abbreviations
abbr cls 'clear'
abbr cp 'cp -v'
abbr fm 'ranger'
abbr md 'mkdir -vp'
abbr mv 'mv -v'
abbr py 'python'
abbr q 'exit'
abbr rm 'rm -v'
abbr rmr 'rm -rfv'
abbr v 'vim'
abbr vc 'vim ~/.config/fish/config.fish'
abbr vd 'vimdiff'
abbr vp 'vim ~/.config/fish/functions/fish_prompt.fish'
abbr vrc 'vim ~/.vimrc'
abbr vw 'vim -R'
abbr ~ 'cd ~'

# GIT abbreviations
abbr gs 'git status'
abbr gb 'git branch'

# Docker abbreviations
abbr dk 'docker'
abbr dkp 'docker ps -a'
abbr dki 'docker images'
abbr dkr 'docker run -p 8080:8080'
abbr dke 'docker exec'
abbr dkd 'docker rm'

# --- Functions ---

# custom fish greetings
function fish_greeting
    #if begin type -q fortune; and type -q cowsay; end
    #    fortune | cowsay -f tux
    if type -q winfetch.bat
        winfetch.bat
    else
        echo "              __________________                                                                                           "
        echo "          /\  \   __           /  /\    /\         Your work is going to fill a large part of your life,                   "
        echo "         /  \  \  \         __/  /  \  /  \        and the only way to be truly satisfied is to do what you believe        "
        echo "        /    \  \       _____   /    \/    \       is great work. And the only way to do great work is to love what you do."
        echo "       /  /\  \  \     /    /  /            \      If you haven’t found it yet Keep Looking. Don't settle.                 "
        echo "      /        \  \        /  /      \/      \     As with all matters of the heart, you’ll know when you find it.         "
        echo "     /          \  \      /  /                \                                                                            "
        echo "    /            \  \    /  /                  \                                                              — Steve Jobs "
        echo "   /              \  \  /  /                    \                                                                          "
        echo "  /__            __\  \/  /__                  __\                                                                         "
        echo ""
    end
end


# docker show status of all entities: images, containers, volumes
function dkls
    if type -q docker
        echo "# Docker Images:"
        docker images
        echo ""
        echo "# Docker Containers:"
        docker ps -a
        echo ""
        echo "# Docker Volumes:"
        docker volume ls
    end
end

# Abbreviation for managing dotfiles
function dtf
    git --git-dir=$HOME/dotfiles --work-tree=$HOME $argv
end

# Python env activate for fish shell
function penv
    set PY_ENV_FILE (find -type f -iname "activate.fish")
    source $PY_ENV_FILE
end

# Reload fish config after changes in this file
function recnf
    source ~/.config/fish/config.fish
end

function lh
    ls -Ad .* --group-directories-first
end

# Interface for: Google searching, Opening web links, either
# directly Or in incognito mode.
function web
    argparse 'h/help' 'i/incog' 's/srch' 'g/github' -- $argv

    if not set -q BROWSER
        echo "Env variable $BROWSER needs to be set for this command to work."
        return 0
    end
    if set -q _flag_help
        echo "web [-h|--help]"
        echo "web [-i|--incog] <WebAddress>"
        echo "web [-i|--incog] [-s|--srch] <Search String>"
        echo "web [-i|--incog] [-g|--github]"
        return 0
    end

    set -l _srch_txt "https://www.google.com/search?q=$argv[1]"
    set -l _github_repo "https://github.com/aniketgm"
    if set -q _flag_incog; and set -q _flag_srch
        $BROWSER --private $_srch_txt
    else if set -q _flag_incog; and set -q _flag_github
        $BROWSER --private $_github_repo
    else if set -q _flag_srch
        $BROWSER $_srch_txt
    else if set -q _flag_github
        $BROWSER $_github_repo
    else if set -q _flag_incog
        $BROWSER --private $argv[1]
    else
        $BROWSER $argv[1]
    end
end

# Open emacs in fullscreen mode.
function ef
    $WINHOME/Downloads/emacs-27.2-x86_64/bin/runemacs.exe -fs $argv &
    # emacs -fs $argv &
end

# GIT function to add and commit
function gac --description "Add and Commit a file into source control"
    argparse 'h/help' 'f/file=' 'm/msg=' -- $argv
    
    if set -q _flag_help
        echo "gac [ -h|--help ]                          Show this help."
        echo "    [ [-f|--file] <file_or_folder_to_add>] Add to git source control."
        echo "    [ [-m|--msg] <message_string>]         Commit changes with given message."
        echo "    If -m is not specified, changes will not be committed."
        return 0
    end
    if set -q _flag_file
        echo "Adding file [" $_flag_file "] to source control ..."
        git add $_flag_file
    else
        echo "Adding all file(s) to source control ..."
        git add .
    end
    if set -q _flag_msg
        echo "Committing with msg:" $_flag_msg
        git commit -m $_flag_msg
    else
        echo "Not committed. Only added file(s) to source control."
        echo "If this was intensional, check 'git status' for added files."
        return 0
    end
end

function gp --description 'push <file> Or <folder> to Github site.'
    if test (count $argv) -lt 1
        git push origin master
    else if test (count $argv) -lt 2
        git push origin $argv[1]
    else
        git push $argv
    end
end

