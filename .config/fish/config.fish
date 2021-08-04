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

set fish_greeting
set PATH '~/bin' $PATH
set PATH '/cygdrive/c/Program Files/MongoDB/Server/4.4/bin/' $PATH
set PATH '/cygdrive/c/Program Files/Docker/Docker/' $PATH
set -x WIN_HOME '/cygdrive/c/Users/eo5ayt'
set -x BROWSER '/home/eo5ayt/bin/opera'

# --- Abbreviations ---

# Learning directory abbreviations
abbr cdl 'cd /cygdrive/d/Learning'
abbr cgo 'cd /cygdrive/d/Learning/Go'
abbr cja 'cd /cygdrive/d/Learning/JavaScript'
abbr cpy 'cd /cygdrive/d/Learning/Python'
abbr cmb 'cd /cygdrive/d/Learning/Python/LearningFlask/microblog'
abbr cwb 'cd /cygdrive/d/Learning/WebDevelopment'
abbr cgh 'cd /cygdrive/d/Learning/GithubRepos'

# Other abbreviations
abbr cls 'clear'
abbr cp 'cp -v'
abbr ent 'cd /cygdrive/c/Users/eo5ayt/Documents/MyData/Entertainment'
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
abbr vw 'view'
abbr ~ 'cd ~'

# GIT abbreviations
abbr gs 'git status'
abbr gb 'git branch'

# --- Functions ---

# Abbreviation for managing dotfiles
function dft
    git --git-dir=$HOME/dotfiles --work-tree=$HOME $argv
end

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
    emacs -fs $argv &
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

