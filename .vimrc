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

" Show Tab as »»»» and trailing spaces as · symbol
set listchars=tab:»»,trail:·

" Save backups to separate directory
set backupdir=~/.vim/backup

" Save swap files to separate directory
set directory=~/.vim/swap

" Check for syntax errors in PHP
autocmd FileType php set makeprg=clear;php\ -l\ %
autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l

" Mark lines if they are longer than 100 symbols or having wite spaces
autocmd FileType python,php call matchadd('ErrorMsg', '  \+$', -1)
autocmd FileType python,php call matchadd('ErrorMsg', '\%>100v.\+', -1)

" <F3> - to enter currently editing files list
map <F3> :BufExplorer<CR>

" <SHIFT + t> - trim white spaces in lines end
map <s-t> :%s/  \+$//g<CR>

" In insert mode make some common functions
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
map { {<CR>}<ESC>O

" If already closed, check maybe it's already closed
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>

" Uncomment lines to enable auto quotes closing
inoremap \" <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

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

" Omnicomplete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Load template from .vim/templates/ directory
function Template(name)
    if (filereadable($HOME . '/.vim/templates/' . a:name))
       %d
       silent execute '0r ' . $HOME . '/.vim/templates/' . a:name
    else
        execute 'echo "There is no template with this name at ' $HOME . '/.vim/templates/' . a:name . '"'
    endif
endfunction

command -nargs=1 Template call Template(<args>)
