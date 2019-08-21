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

" numbers in the gutter settings
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
    Plug 'SirVer/ultisnips'
        let g:UltiSnipsExpandTrigger = '<TAB>'
        let g:UltiSnipsJumpForwardTrigger = '<TAB>'
        let g:UltiSnipsJumpBackwardTrigger = '<s-TAB>'
        let g:UltiSnipsSnippetDirectories=["UltiSnips"]
    Plug 'honza/vim-snippets'
    Plug 'lervag/vimtex'
        let g:tex_flavor='latexmk'
        let g:vimtex_latexmk_enabled = 1
        let g:vimtex_latexmk_options = "-pvc -pdflua -silent""
        let g:vimtex_quickfix_mode=0
        set conceallevel=1
        let g:tex_conceal='abdmg'
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

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" COC Snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Cleanup log files for vimtex when done
augroup MyVimtex
  autocmd!
  autocmd User VimtexEventQuit call vimtex#latexmk#clean(0)
augroup END

