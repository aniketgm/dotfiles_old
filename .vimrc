"              __________________ 
"          /\  \   __           /  /\    /\           Author      : Aniket Meshram [AniGMe]
"         /  \  \  \         __/  /  \  /  \          Description : This file contains all my vimrc configurations.
"        /    \  \       _____   /    \/    \                       Vim-Plug is used for managing plugins.
"       /  /\  \  \     /    /  /            \                      NerdTree is used for file navigation. 
"      /        \  \        /  /      \/      \
"     /          \  \      /  /                \      Github Repo : https://github.com/aniketgm/dotfiles
"    /            \  \    /  /                  \
"   /              \  \  /  /                    \
"  /__            __\  \/  /__                  __\
"

" Plugins list [Vim-Plug]
" -----------------------
call plug#begin('~/.vim/plugged')

Plug 'Chiel92/vim-autoformat'
Plug 'JayDoubleu/vim-pwsh-formatter'
Plug 'Konfekt/vim-alias'
Plug 'fs111/pydoc.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'nvie/vim-flake8'
Plug 'pprovost/vim-ps1'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'

call plug#end()

" 'let' and 'set' configuration
" -----------------------------
set backspace=indent,eol,start
set expandtab
set laststatus=2
set noshowmode
set noswapfile
set path+=**
set rnu nu
set shiftwidth=4
set smartindent
set tabstop=4
set term=xterm
set splitbelow
set splitright
set shell=fish
colorscheme koehler 

let g:syntastic_python_flake8_args='--ignore=E126,E266,E302,E305,E402,E501,F821'
let g:pydoc_cmd='python -m pydoc'
let g:pydoc_open_cmd='tabnew'
let g:pydoc_highlight=0
let g:airline_theme='angr'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_mode_map = {
  \ '__'     : '-',
  \ 'c'      : 'C',
  \ 'i'      : 'I',
  \ 'ic'     : 'I',
  \ 'ix'     : 'I',
  \ 'n'      : 'N',
  \ 'multi'  : 'M',
  \ 'ni'     : 'N',
  \ 'no'     : 'N',
  \ 'R'      : 'R',
  \ 'Rv'     : 'R',
  \ 's'      : 'S',
  \ 'S'      : 'S',
  \ ''     : 'S',
  \ 't'      : 'T',
  \ 'v'      : 'V',
  \ 'V'      : 'V',
  \ ''     : 'V',
  \ }

if !has("gui_running")
    set t_Co=256
endif

" Other Configurations
" --------------------
function RecognizeXML()
    let g:xml_syntax_folding=1
    au FileType xml setlocal foldmethod=syntax
    setf xml
endfunction
nnoremap <silent> <F2> :call RecognizeXML()<CR>

nmap <F3> :NERDTreeToggle<CR>
nmap <Leader>f :NERDTreeFind<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
