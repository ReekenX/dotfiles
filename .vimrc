" Theme {{{
syntax on

" Show line numbers in editor
set number

" Display not printable characters
set list
set listchars=tab:»»,trail:·,extends:#,nbsp:·

" Disable poor HTML rendering - not really compatible with HTML5 or
" any frontend JavaScript frameworks
let html_no_rendering = 1

" Theme customization
hi Comment term=underline ctermfg=8
hi Folded term=underline ctermfg=8
hi Pmenu ctermfg=0 ctermbg=White guibg=LightBlue
hi LineNr ctermfg=8
" }}}

" Edit behaviour {{{
" Mapleader from \ to ,
let mapleader=","

" Prefered file format
set fileformat=unix

" Encoding
scriptencoding utf-8
set termencoding=utf-8

" Set tab to 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
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

" Allow cursor to go in to 'invalid' places
set virtualedit=all

" Share keyboard with OS
set clipboard+=unnamed

" When in git commit message - set cursor to the first line
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, strlen(getline(1))+1, 0])

" Allow backspace on everything in insert mode
set backspace=indent,eol,start
" }}}

" Search {{{
" Ignore case in search and replace
set ignorecase

" Found text will be highlighted and search will be repeated over file
set incsearch

" Smart search: if lowercase ignore case of matches, if not case-sensitive search
set smartcase

" Advanced search
nnoremap // :Rg <CR>
nnoremap <leader>. :nohl<CR>

" Fix for `Rg` command including file name in search options
command! -bang -nargs=* Rg call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
" }}}

" Backups and swap {{{
set backup
silent execute '!mkdir -p /tmp/.vim-backup-$USER'
set backupdir=/tmp/.vim-backup-$USER

set noswapfile
:au BufWritePre * let &bex = '-' . strftime("%Y-%m-%d_%H:%M") . '~'
" }}}

" Folding rules {{{
set foldenable
set foldcolumn=0
set foldmethod=marker
set foldlevelstart=0

" For these commands open folding by default
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
" }}}

" Autosave {{{
set updatetime=1000

function! AutoSave()
  if expand('%:p') != ''
    silent update
  endif
endfunction
autocmd CursorHold,CursorHoldI * call AutoSave()
" }}}

" Auto create directories on save if not exists {{{
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
" VIM moving based on screen works better for long text files
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" Use the damn hjkl keys instead of arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Fixed copying. The number one annoying feature of VIM!
xnoremap p pgvy "

" Quick search from visual text
vnorem // y/<c-r>"<cr>

" Fixing "broken" VIM regexp - all characters now should be escaped
nnoremap / /\v
cnoremap %s/ %s/\v

" Don't press the SHIFT in normal mode
nnoremap ; :

" Expand %% to full file directory (without filename!)
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" <SHIFT + t> - trim whitespace and restore to original cursor position
map <s-t> :mark a<CR>:%s/ +$//g<CR>'a'

" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" Quickly get out of insert mode without your fingers having to leave the home row
inoremap jj <Esc>

" Enter currently editing files list
map <leader>e :Ex<CR>
" }}}

" Spell Checker {{{
function! ToggleSpellCheck()
  set spell!
  if &spell
    echo "Spellcheck ON"
  else
    echo "Spellcheck OFF"
  endif
endfunction

nnoremap <silent> <Leader>sp :call ToggleSpellCheck()<CR>
" }}}

" Ignore rules for file editing {{{
set wildmenu
set wildchar=<tab>
set wildmode=list:full
set wildignore+=*.swp,*.bak,*.pyc,*.pyo,*.so,*~,*.zip,*.gz,*.tar
set wildignore+=virtual/,.virtualenv/,upload/,uploads/,node_modules/
" }}}

" Omnicomplete plugin settings {{{
autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

set completeopt=menuone,longest
" }}}

" Repeat very last command in the next tmux window for quick command lines testing {{{
nnoremap <Leader>r :call <SID>TmuxRepeat()<CR>
function! s:TmuxRepeat()
    silent! exec "!clear && tmux select-pane -l && tmux send up enter && tmux select-pane -l"
    redraw!
endfunction
" }}}

" Poor man surrounding system {{{
vnoremap <silent> S( xi()<esc>P
vnoremap <silent> S[ xi[]<esc>P
vnoremap <silent> S{ xi{}<esc>P
vnoremap <silent> S' xi''<esc>P
vnoremap <silent> S" xi""<esc>P
" }}}

" Load plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/vimoutliner'
Plug 'tmhedberg/matchit'
Plug 'ReekenX/vim-rename2'
Plug 'terryma/vim-smooth-scroll'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-scripts/auto-pairs-gentle'
Plug 'editorconfig/editorconfig-vim'
Plug 'webdevel/tabulous'
Plug 'posva/vim-vue'
Plug 'cakebaker/scss-syntax.vim'
Plug 'leafgarland/typescript-vim'
Plug 'srstevenson/vim-picker'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'
Plug 'honza/vim-snippets'
Plug 'djoshea/vim-autoread'
if executable('node')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif
if executable('ctags')
  Plug 'ludovicchabant/vim-gutentags'
endif

call plug#end()
" }}}

" Ctags && Vim Gutentags plugin settings {{{
" Force to look for ctags file in your project .git/tags
function! GetProjectFolderPath()
  let result = system('git rev-parse --show-toplevel')
  return substitute(result, "\n", "", "")
endfunction

let ctagsfolderpath = GetProjectFolderPath()
let &tag = GetProjectFolderPath() . '/.git/tags'
let g:gutentags_ctags_tagfile = GetProjectFolderPath() . '/.git/tags'
let g:gutentags_ctags_extra_args = ['--tag-relative=no']
if executable('rg')
  let g:gutentags_file_list_command = 'rg --files'
endif
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

" VIM Smooth Scroll plugin settings {{{
nnoremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 2)<CR>
nnoremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 2)<CR>
set scrolloff=3
" }}}

" Nerd commenter plugin settings {{{
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign = 'left'
" }}}

" VIM Surround plugin settings {{{
let g:surround_{char2nr('„')} = "„\r“"
" }}}

" VIM Vue plugin settings {{{
let g:vue_disable_pre_processors=1
autocmd FileType vue syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css.less.pug
" }}}

" VIM Picker plugin settings {{{
nmap <leader>f <Plug>(PickerEdit)
nmap <leader>F <Plug>(PickerTabedit)
nmap <leader>b <Plug>(PickerBuffer)
nmap <leader>t <Plug>(PickerTag)
" }}}

" VIM COC Snippets plugin settings {{{
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
" }}}
