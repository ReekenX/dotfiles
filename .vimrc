" Nocompatible mode makes VIM more friendly than old VI
set nocompatible

" Enable syntax hightlighting
syntax on

" Default files encoding UTF-8
set encoding=utf-8

" Enable wrap mode to see long code lines
set wrap

" Don't make text auto-wrapping
set textwidth=0
"
" Use spaces when inserting tabs
set expandtab

" Enable ctags support
set tag=./tags,tags

" Set tab to 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" If file is not modified in VIM but changed outside, reload it
set autoread

" For new lines automaticly indent by current line indent
set autoindent

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

" Found text will be highlighted and search will be repeated in file content
set incsearch

" Display inprintable characters
set list

" Show Tab as >···
set listchars=tab:»»,trail:·

" Save backups to separate directory
set backupdir=~/.vim/backup

" Save swap files to separate directory
set directory=~/.vim/swap

" Check for syntax errors in PHP
set makeprg=clear;php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l

" Mark lines if they are longer than 100 symbols or having wite spaces
call matchadd('ErrorMsg', '  \+$', -1)
call matchadd('ErrorMsg', '\%>100v.\+', -1)

" Mappings
" <F2> - save current VIM session
" <F3> - to enter currently editing files list
" <F4> - show functions list in current file
" <F8> - restore VIM session
" <F9> - checks PHP errors and jumps to error line (after manual ENTER press)
" <SHIFT + t> - trim white spaces in file.
map <F2> :mksession! ~/.vim/swap/session<CR>
map <F3> :BufExplorer<CR>
map <F4> :il function<CR>:
map <F8> :source ~/.vim/swap/session<CR>
map <F9> :make<CR><CR>
map <s-t> :%s/  \+$//g<CR>

" In insert mode make some common functions
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
map { {<CR>}<ESC>O

" If already closed, check maybe it's already closed
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>

" Uncomment lines to enable auto quotes closing
" inoremap \" <c-r>=QuoteDelim('"')<CR>
" inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

function QuoteDelim(char)
  let line = getline('.')
  let col = col('.')
  if line[col - 2] == "\\"
    return a:char
  elseif line[col - 1] == a:char
    return "\<Right>"
  else
    return a:char.a:char."\<ESC>i"
  endif
endf

filetype plugin on

