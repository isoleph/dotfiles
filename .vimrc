set encoding=utf-8 
syntax enable           "syntax highlighting

"set shift/tab options
set expandtab " set spaces when tab is pressed
set textwidth=120
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

set number              " numbers in gutter
set showcmd
set showmatch
set cursorline
filetype indent on
set ttyfast

set wildmenu
set lazyredraw
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase
set autowrite
set laststatus=2

set showmode
set showcmd
set matchpairs+=<:>

nnoremap j gj
nnoremap k gk

colorscheme ir_black

augroup configgroup 
augroup END
