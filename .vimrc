set shell=zsh
set encoding=utf-8 
syntax enable

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

filetype indent on
set autoindent

set noshowmode
set showcmd
set showmatch
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

" numbers in the gutter
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" set a spell checker
autocmd FileType latex,tex,md,markdown,text setlocal spell

" Close those brackets!
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" unset last search pattern by pressing enter
nnoremap <CR> :noh<CR><CR>

" Plugin Settings
" -------------------------------------------

" call junegunn's plugin feature 
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install other plugins with vim-plug 
call plug#begin('~/.vim/plugged')
    Plug 'junegunn/vim-plug'        "package manager
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-surround'       "surround plugin
    Plug 'tpope/vim-repeat'         "support . for above
    Plug 'flazz/vim-colorschemes'   "colorschemes for vim
    Plug 'joshdick/onedark.vim'
    Plug 'itchyny/lightline.vim'    "vim mode line
    Plug 'scrooloose/nerdtree'      "directory tree
    Plug 'neoclide/coc.nvim', {'branch': 'release'}     "autocomplete
call plug#end()

" Set lightline color----
let g:lightline = {
    \ 'colorscheme': 'wombat',
\ }

"set colorscheme----
colorscheme onedark
hi Normal ctermbg=none
highlight NonText ctermbg=none

"NERDTree Settings ----
"open NERDTree if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open NERDTree if directory is input
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

"NERDTree Remap
nmap <C-n> :NERDTreeToggle<CR>

" Completion for COC
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
