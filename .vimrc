" No compatible mode makes VIM more friendly than old VI
set nocompatible

" Load pathogen and plugins {{{
filetype off
filetype plugin on
filetype plugin indent on

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

" Don't force to write when switching to other file
set hidden

" Enable ctags support
set tag=./.ctags,.ctags

" Keep commands history longer (by default keeps only 20 commands)
set history=1000

set viminfo='50,:50,<50,s10,h,n/tmp/.viminfo

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
set hlsearch

" Smart search: if lowercase ignore case of matches, if not case-sensitive
" search
set smartcase

" Display not printable characters
set list
set listchars=tab:»»,trail:·,extends:#,nbsp:·

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

" Only UTF-8!
scriptencoding utf-8
set encoding=utf-8

" Enable syntax highlighting
syntax on

" Encoding
set termencoding=utf-8
set encoding=utf-8

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" Just file formats
set fileformat="unix,dos,mac"

" Mark line where my cursor are
set cursorline

" Set tab to 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Don't wrap text (it's like punishment for bad code)
set nowrap
set textwidth=0

" Enable mouse features
set mouse=a

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

" No annoying beeping
set noeb vb t_vb=

let g:AutoClosePairs_add = "' \" \[\]"

" Fix for YouCompleteMe and UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
" }}}

" Backups and swap {{{
set backup
set backupdir=~/.vim/backup
set noswapfile
" }}}

" Mappings {{{
" Note that <F2> is reserved for toggle paste mode

" VIM moving based on screen works better for long text files
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" Fixing "broken" VIM regexp
nnoremap / /\v
cnoremap %s/ %s/\v

" Don't press the SHIFT in normal mode
nnoremap ; :

" Expand %% to full file directory (without filename!)
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" move to beginning/end of line
nnoremap B ^
nnoremap E $

nmap <silent> ,/ :nohlsearch<CR>

" Tab navigation
nmap ,p :bp<CR>
nmap ,n :bn<CR>

" <F3> - to enter currently editing files list
map <F3> :BufExplorer<CR>

" <F5> - to enter `Ex`
map <F5> :Explore<CR>

" <F3> - to enter currently editing files list
map <F3> :BufExplorer<CR>

" MUST HAVE EVERYONE!
" <SHIFT + t> - trim whitespace and restore to original cursor position
map <s-t> :mark a<CR>:%s/ +$//g<CR>'a'

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

"{{{ Ignore file types and directories
set wildmenu
set wildchar=<tab>
set wildmode=list:full
set wildignore+=*.swp,*.bak,*.pyc,*.pyo,*.so,*~
set wildignore+=virtual/,.virtualenv/,eggs/
" }}}

" File types options {{{
" If VIM founds project.vim file in project root, it will be loaded.
" This is required if project has specific settings.
silent! source project.vim

autocmd BufEnter *.otl set foldlevel=0
autocmd BufEnter *.otl set textwidth=80
autocmd BufEnter *.otl set wrap
autocmd Bufenter *.shpaml set syntax=shpaml
autocmd Bufenter *.py match ErrorMsg '\%>80v.\+'

" Automatically load common libraries
set path+=website/**
set path+=src/**

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
