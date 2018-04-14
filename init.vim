call plug#begin()
Plug 'donRaphaco/neotex', { 'for': 'tex' }
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-startify'
call plug#end()

set encoding=utf8

set noerrorbells
set laststatus=2
set modeline
set noshowmode
set number
set nojoinspaces
set scrolloff=20
set fillchars+=vert:\
set splitbelow
set splitright

syntax enable

filetype indent on

set wildmenu
set showmatch
set list

set autoindent
filetype plugin indent on

set tabstop=4 softtabstop=4 expandtab shiftwidth=4
set linebreak
set formatoptions+=o
set lazyredraw

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup


