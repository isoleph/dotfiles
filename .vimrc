set encoding=utf-8 
syntax enable           "syntax highlighting

"set shift/tab options
set expandtab " set spaces when tab is pressed
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

set number              " numbers in gutter
set noshowmode
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

set showcmd
set matchpairs+=<:>

nnoremap j gj
nnoremap k gk

augroup configgroup 
augroup END

" Plugin Settings

" call  junegunn's plugin feature 
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    Plug 'junegunn/vim-plug'
    Plug 'tpope/vim-sensible'
    Plug 'flazz/vim-colorschemes'
    Plug 'itchyny/lightline.vim'

    Plug 'scrooloose/nerdtree'
call plug#end()

" Set lightline color
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ }

"set colorscheme
colorscheme ir_black

""NERDTree Customizations
autocmd vimenter * NERDTree
"open NERDTree if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" open NERDTree if directory is input
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

"NERDTree Remap
nmap <C-n> :NERDTreeToggle<CR>
