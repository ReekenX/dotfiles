" No compatible mode makes VIM more friendly than old VI
set nocompatible
scriptencoding utf-8
set encoding=utf-8

" Load pathogen and plugins {{{
filetype off
filetype plugin on
filetype plugin indent off

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype on
filetype plugin on
" }}}

" VIM behaviour {{{
" Always show what mode we're using
set showmode

" Don't update the display while executing macros
set lazyredraw

" Enable 256 colors for VIM
set t_Co=256

" Pyflake settings
highlight SpellBad ctermfg=Gray
let g:pyflakes_use_quickfix = 0

" Default theme
colorscheme wombat256

" Hide buffer
set hidden

" Enable ctags support
set tag=./tags,tags

" Keep commands history longer (by default keeps only 20 commands)
set history=1000

" GUI settings
set title

" Shows information on VIM bottom
set ruler

" Show line numbers in editor
set number

" Ignore case in search and replace
set ignorecase

" Found text will be highlighted and search will be repeated over file
set incsearch

" Smart search: if lowercase ignore case of matches, if not case-sensitive
" search
set smartcase

" Display not printable characters
set list
set listchars=tab:»»,trail:·,extends:#,nbsp:·

" Keep VIM history even file is closed
set viminfo='100,:100,<100,/100,%100
set viminfo+=n~/.vim/viminfo
" }}}

" Folding rules {{{
set foldenable
set foldcolumn=2
set foldmethod=marker
set foldlevelstart=0

" For these commands open folding by default
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

" Change the color of folding to make it less annnoying
highlight Folded ctermbg=black ctermfg=blue cterm=none
" }}}

" Edit behaviour {{{
" Mapleader from \ to ,
let mapleader=","

" Enable syntax highlighting
syntax on

" Encoding
set termencoding=utf-8
set encoding=utf-8

" More faster scrolling
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" Just file formats
set fileformat="unix,dos,mac"

" I love VIM
xnoremap p pgvy

" Mark line where my cursor are
set cursorline

" Set tab to 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Enable wrap mode to see long code lines
set wrap
set textwidth=0

" Enable mouse features
set mouse=a
"
" For new lines automatically indent by current line indent
set autoindent
set copyindent

" No autoindent in paste mode
set pastetoggle=<F2>

" Show matching for symbols like () and etc.
set showmatch

" Allow cursor to go in to 'invalid' places
set virtualedit=all

" Allow backspace on everything in insert mode
set backspace=indent,eol,start

" Support for Lithuanian quotes (VIM SURROUND plugin)
let g:surround_{char2nr('„')} = "„\r“"

" Easily resize windows with +/-
if bufwinnr(1)
    map + <C-W>+
    map - <C-W>-
endif
" }}}

" Backups and swap {{{
set backup
set backupdir=~/.vim/backup
set noswapfile
" }}}

" Mappings {{{
" Note that <F2> is reserved for toggle paste mode

" Don't press the SHIFT in normal mode
nnoremap ; :

" <F3> - to enter currently editing files list
map <F3> :BufExplorer<CR>

" <F5> - to enter `Ex`
map <F5> :Explore<CR>

" <F3> - to enter currently editing files list
map <F3> :BufExplorer<CR>

" <SHIFT + t> - trim white spaces in lines end
map <s-t> :%s/ \+$//g<CR>

" Avoid <F1> when we want <ESC> to press
nnoremap <F1> <Esc>

" After using :grep navigate throught found lines with CTRL+N/P
nmap <silent> <C-N> :cn<CR>zv
nmap <silent> <C-P> :cp<CR>zv

" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" Use the damn hjkl keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Quickly get out of insert mode without your fingers having to leave the
" home row (either use 'jj' or 'jk')
inoremap jj <Esc>
inoremap jk <Esc>

nmap <F8> :python RunUnitTestsUnderCursor()<CR>
" }}}

" File types options {{{
" Ignore these file types on :e
set wildmenu
set wildmode=list:full
set wildignore=*.swp,*.bak,*.pyc

" If VIM founds project.vim file in project root, it will be loaded.
" This is required if project has specific settings.
silent! source project.vim

" Protect large files from sourcing and other overhead.
" Files become read only
let g:LargeFile=10
if !exists("my_auto_commands_loaded")
  let my_auto_commands_loaded = 1
  " Large files are > 10M
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowritefile (is read-only)
  " undolevels=-1 (no undo possible)
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
    augroup END
  endif

autocmd BufEnter *.otl set foldlevel=0
autocmd BufEnter *.otl set textwidth=80
autocmd BufEnter *.otl set wrap
autocmd Bufenter *.shpaml set syntax=shpaml

" Omnicomplete {{{
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

set completeopt=menuone,longest
" }}}

" VIM Outliner {{{
autocmd! BufRead,BufNewFile *.otl setfiletype vo_base
autocmd BufRead,BufNewFile *.otl colorscheme vo_dark
autocmd BufRead,BufNewFile *.otl filetype plugin indent on
autocmd BufRead,BufNewFile *.otl set nolist
" }}}
" }}}

" GVIM settings {{{
if has("gui_running")
    set lines=999 columns=999
endif
" }}}
