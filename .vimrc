" Nocompatible mode makes VIM more friendly than old VI
set nocompatible

" Enable syntax hightlighting
syntax on

" Default files encoding UTF-8
set encoding=utf-8

" Enable wrap mode to see long code lines
set wrap

" Hide buffer
set hidden

" Enable mouse features
set mouse=a

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
autocmd FileType otl set nolist

" Save backups to separate directory
set backup
set backupdir=~/.vim/backup

" Save swap files to separate directory
set directory=~/.vim/swap

" <F3> - to enter currently editing files list
map <F3> :BufExplorer<CR>

" Check for syntax errors in PHP
autocmd FileType php set makeprg=clear;php\ -l\ %
autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l

" Mark lines if they are longer than 100 symbols or having wite spaces
autocmd FileType python,php call matchadd('ErrorMsg', '  \+$', -1)
autocmd FileType python call matchadd('ErrorMsg', '\%>80v.\+', -1)
autocmd FileType php call matchadd('ErrorMsg', '\%>100v.\+', -1)

" <SHIFT + t> - trim white spaces in lines end
map <s-t> :%s/  \+$//g<CR>

" Check maybe it's already closed
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap \" <c-r>=ClosePair('"')<CR>
inoremap ' <c-r>=ClosePair("'")<CR>

function ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

filetype on
filetype plugin on
" filetype plugin indent on

" For SnipMate
autocmd FileType python set ft=python.django
autocmd FileType html set ft=htmldjango.html

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

" VimOutliner settings
let otl_install_menu=0
let otl_install_toobalr=0
let no_otl_maps=0
let no_otl_insert_maps=0

let otl_bold_headers=0
let otl_use_thlnk=1
let otl_text_view=1

" This fixes PyFlakes error: background color overlaps text color
highlight SpellBad ctermfg=Gray

