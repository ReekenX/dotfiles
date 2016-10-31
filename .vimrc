" No compatible mode makes VIM more friendly than old VI
set nocompatible

" Load plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'jlanzarotta/bufexplorer'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/vimoutliner'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-surround'
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'ReekenX/vim-rename2'
Plug 'SirVer/ultisnips'
Plug 'othree/html5.vim'
Plug 'terryma/vim-smooth-scroll'
Plug 'kchmck/vim-coffee-script'
Plug 'matze/vim-move'
Plug 'vobornik/vim-mql4'
Plug 'kien/ctrlp.vim'
Plug 'osyo-manga/vim-brightest'
Plug 'honza/vim-snippets'
Plug 'benekastah/neomake'
Plug 'terryma/vim-multiple-cursors'
Plug 'cakebaker/scss-syntax.vim'
Plug 'mattn/emmet-vim'

call plug#end()
" }}}

" Theme {{{
syntax on
set t_Co=256
set t_md=
colorscheme desert_modified
" }}}

" VIM behaviour {{{
" Always show what mode we're using
set showmode

" Encoding
scriptencoding utf-8
set termencoding=utf-8

" Don't update the display while executing macros
set lazyredraw

" No status line with useless info
set laststatus=0

" Don't force to write when switching to other file
set hidden

" Keep commands history longer (by default keeps only 20 commands)
set history=1000

" set viminfo='50,:50,<50,s10,h,n/tmp/.viminfo

" GUI settings
set title

" No ruler line with column/line - useless info
set noruler

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

" }}}

" Folding rules {{{
set foldenable
set foldcolumn=0
set foldmethod=marker
set foldlevelstart=0

" For these commands open folding by default
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

" Change the color of folding to make it less annnoying
highlight Folded ctermbg=black ctermfg=blue cterm=none

" Disable poor HTML underline feature
hi link htmlLink NONE
" }}}

" Edit behaviour {{{
" Mapleader from \ to ,
let mapleader=","

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

" Enable mouse features for normal mode only, to prevent paste from explosion
set mouse=n

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

set clipboard+=unnamedplus
" }}}

" Backups and swap {{{
set backup
silent execute '!mkdir -p /tmp/.vim-backup'
set backupdir=/tmp/.vim-backup
set noswapfile
" }}}

" Autosave {{{
set updatetime=1000

function AutoSave()
    if expand('%:p') != ''
      silent update
    endif
endfunction
autocmd CursorHold,CursorHoldI * call AutoSave()
" }}}

" Auto validate code {{{
if has('nvim')
    autocmd! BufWritePost * Neomake
endif
" }}}

" Auto create directories on save {{{
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
" }}}

" Keyboard mappings {{{
" Note that <F2> is reserved for toggle paste mode

" VIM moving based on screen works better for long text files
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" Use the damn hjkl keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Fixed copying. The number one annoying feature of VIM!
xnoremap p pgvy "

" Quick search from visual text
vnorem // y/<c-r>"<cr>

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

" Tab navigation
nmap ,p :bp<CR>
nmap ,n :bn<CR>

" <F3> - to enter currently editing files list
map <leader>b :BufExplorer<CR>
map <leader>e :Ex<CR>

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

" Quickly get out of insert mode without your fingers having to leave the
" home row (either use 'jj' or 'jk')
inoremap jj <Esc>
inoremap jk <Esc>

" Quick refactoring
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
nnoremap gR gD:%s/<C-R>///gc<left><left><left>}]
" }}}

"{{{ Ignore rules
set wildmenu
set wildchar=<tab>
set wildmode=list:full
set wildignore+=*.swp,*.bak,*.pyc,*.pyo,*.so,*~,*.zip,*.gz
set wildignore+=virtual/,.virtualenv/,eggs/,upload/,uploads,node_modules
" }}}

" Automatic Ctags {{{
" Automatic ctags (yes, I tried autotags plugin - doesn't work for me)
function! CtagsGetGITFilePath()
  let result = system('git rev-parse --show-toplevel') . "/.git/"
  return substitute(result, "\n", "", "")
endfunction

let tagfilename = CtagsGetGITFilePath()
let &tag = tagfilename . 'tags'
" }}}

" File types options {{{
" If VIM founds .git/settings.vim file in project root, it will be loaded.
" This is required if project has specific settings.
exec "silent! source" CtagsGetGITFilePath() . "project.vim"

autocmd Bufenter *.shpaml set syntax=shpaml
autocmd Bufenter *.coffee set syntax=coffee
autocmd Bufenter *.mqh set syntax=mql4
autocmd Bufenter *.mq4 set syntax=mql4
autocmd Bufenter *.coffee set syntax=coffee
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2

" When in git commit message - set cursor to the first line
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, strlen(getline(1))+1, 0])

" In PHP code allow HTML code snippets (yeah, that's the way professionals code)
au BufRead *.php set ft=php.html
au BufNewFile *.php set ft=php.html

" Automatically load common libraries
set path+=website/**
set path+=src/**
" }}}

" Make ENTER key smarter when coding HTML {{{
function EnterOrIndentTag()
  let line = getline(".")
  let col = getpos(".")[2]
  let before = line[col-2]
  let after = line[col-1]

  if before == ">" && after == "<"
    return "\<Enter>\<C-o>O\<Tab>"
  endif
   return "\<Enter>"
endfunction
inoremap <expr> <Enter> EnterOrIndentTag()
" }}}

" Omnicomplete plugin settings {{{
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

set completeopt=menuone,longest
" }}}

" VIM Outliner plugin settings {{{
autocmd BufEnter *.otl set foldlevel=0
autocmd BufEnter *.otl set textwidth=80
autocmd BufEnter *.otl set wrap
autocmd BufEnter *.otl set foldenable

autocmd! BufRead,BufNewFile *.otl setfiletype vo_base
autocmd BufRead,BufNewFile *.otl colorscheme vo_dark
autocmd BufRead,BufNewFile *.otl filetype plugin indent on
autocmd BufRead,BufNewFile *.otl set nolist
" }}}
"
" VIM UltiSnips plugin settings {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
" }}}

" VIM Smooth Scroll plugin settings {{{
nnoremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
nnoremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
nnoremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
nnoremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
set scrolloff=3
" }}}

" VIM Move plugin settings {{{
let g:move_key_modifier = 'C'
" }}}

" CTRL-P plugin settings {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_lazy_update = 100
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0

" Fixing "broken" VIM regexp
nnoremap // :CtrlPLine %<cr>
cnoremap %s/ %s/\v
" }}}

" Nerd commenter plugin settings {{{
let NERDSpaceDelims=1
" }}}

" Tagbar plugin settings {{{
let g:tagbar_type_php = {
    \ 'kinds' : [
        \ 'i:interfaces',
        \ 'c:classes',
        \ 'd:constant definitions:0:0',
        \ 'f:functions',
        \ 'j:javascript functions',
    \ ],
\ }
" }}}
