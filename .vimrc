set shell=zsh
set encoding=utf8
set nocompatible
set guifont=FiraCode\ Nerd\ Font:h18
syntax enable

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set conceallevel=3

filetype indent on
set autoindent
set backspace=indent,eol,start

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

" numbers in the gutter; toggle depending on mode
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
""" Close those brackets!
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" unhighlight last search by pressing enter in normal mode
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
    Plug 'junegunn/fzf.vim'         " fuzzy finder
    Plug 'tpope/vim-surround'       "surround plugin
    Plug 'tpope/vim-repeat'         "support . repeat for above
    Plug 'flazz/vim-colorschemes'   "colorschemes for vim
    Plug 'joshdick/onedark.vim'     "greatest theme ever
    Plug 'itchyny/lightline.vim'    "pretty vim mode line
    Plug 'scrooloose/nerdtree'      "directory tree plugin
    Plug 'neoclide/coc.nvim', {'branch': 'release'}         "autocomplete
    Plug 'SirVer/ultisnips'         "snippets repository for vim-snippets
        let g:UltiSnipsExpandTrigger = '<TAB>'
        let g:UltiSnipsJumpForwardTrigger = '<TAB>'
        let g:UltiSnipsJumpBackwardTrigger = '<s-TAB>'
        let g:UltiSnipsSnippetDirectories=["UltiSnips"]
    Plug 'honza/vim-snippets'       "snippets
    Plug 'lervag/vimtex'            "render LaTeX from vim screen
        let g:tex_flavor='latexmk'  "use latexmk and continuous update
        let g:vimtex_latexmk_enabled = 1
        let g:vimtex_latexmk_options = "-pvc -pdflua -silent""
        let g:vimtex_quickfix_mode=0
        let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
        let g:vimtex_view_general_options = '-r @line @pdf @tex'
        let g:vimtex_fold_enabled = 0 "So large files can open more easily
        set conceallevel=1
        let g:tex_conceal='abdmg'
    Plug 'ryanoasis/vim-devicons'
        let g:WebDevIconsOS = 'Darwin'
        let g:webdevicons_conceal_nerdtree_brackets = 1
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight' 
    Plug 'junegunn/goyo.vim'
    Plug 'tpope/vim-markdown'
        let g:markdown_fenced_languages = ['python', 'bash=sh', 'cpp', 'c', 'java', 'haskell', 'javascript', 'html', 'css', 'rust', 'go']
        let java_ignore_javadoc=1
    Plug 'JamshedVesuna/vim-markdown-preview'
        let vim_markdown_preview_github=1
call plug#end()

"set devicon colors
let g:NERDTreeLimitedSyntax = 1

"set colorscheme----
colorscheme onedark 
hi Normal ctermbg=none
highlight NonText ctermbg=none

"NERDTree Settings ----
"open NERDTree if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"open NERDTree if directory is vim argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

"NERDTree Remap
nmap <C-n> :NERDTreeToggle<CR>

"NERDTree Highlighting"
let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1
let g:NERDTreeSyntaxEnabledExtensions = ['c', 'h', "c++", 'java', 'hs', 'js', 'css', 'html', 'py', 'sh', 'go', 'rs', 'md'] 

" Set lightline color----
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component_function': {
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \ }
      \ }

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ' '
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ' '
endfunction

"Completion for COC
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

" COC Snippets on TAB
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" set spellchecker
let g:coc_snippet_next = '<tab>'

" set a spell checker
autocmd FileType latex,tex,md,markdown,text,txt setlocal spell
autocmd BufNewFile,BufRead *.md set ft=markdown spell
syntax spell toplevel
