" Load plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'vimoutliner/vimoutliner'
Plug 'tmhedberg/matchit'
Plug 'terryma/vim-smooth-scroll'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'editorconfig/editorconfig-vim'
Plug 'webdevel/tabulous'
Plug 'posva/vim-vue'
Plug 'cakebaker/scss-syntax.vim'
Plug 'tpope/vim-surround'
Plug 'djoshea/vim-autoread'
Plug 'dense-analysis/ale'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'joshdick/onedark.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'

call plug#end()
" }}}
"
" Theme {{{
syntax on

" Show line numbers in editor
set number

" Display not printable characters set list
set listchars=tab:»»,trail:·,extends:#,nbsp:·

" Disable poor HTML rendering - not really compatible with HTML5 or
" any frontend JavaScript frameworks
let html_no_rendering = 1

" Theme customization
colorscheme onedark
hi Comment term=underline ctermfg=8
hi Folded term=underline ctermfg=8
hi Pmenu ctermfg=0 ctermbg=White guibg=LightBlue
hi LineNr ctermfg=8
hi ColorColumn ctermbg=none
hi Normal ctermbg=none

" No status line
set laststatus=0
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

" Include dash to split words (useful for CSS classes autocompletion for names
" having dash symbol "-")
set iskeyword=@,48-57,_,192-255,-

" When in git commit message - set cursor to the first line
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, strlen(getline(1))+1, 0])

" Allow backspace on everything in insert mode
set backspace=indent,eol,start

" No welcome screen
set shortmess=Fmnrwx
set cmdheight=2

" Autocomplete navigation without arrow keys
inoremap <expr> <c-j> ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> <c-k> ((pumvisible())?("\<C-p>"):("k"))
" }}}

" Search {{{
" Ignore case in search and replace
set ignorecase

" Found text will be highlighted and search will be repeated over file
set incsearch

" Smart search: if lowercase ignore case of matches, if not case-sensitive search
set smartcase

" Clean highlight when requested
nnoremap <leader>. :nohl<CR>
" }}}

" Backups and swap {{{
set backup
silent execute '!mkdir -p /tmp/.vim-backup'
set backupdir=/tmp/.vim-backup

set noswapfile
autocmd BufWritePre * let &bex = '-' . strftime("%Y-%m-%d_%H:%M")
" }}}

" Folding rules {{{
set foldenable
set foldcolumn=0
set foldmethod=marker
set foldlevelstart=0

" For these commands open folding by default
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
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

" Don't press the SHIFT in normal mode
nnoremap ; :

" Expand %% to full file directory (without filename!)
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" Save without :w quickly
inoremap jj <ESC>
nmap ww <ESC>:nohl<CR><ESC>:write!<CR>

" Close buffer
nnoremap <c-x> :bd<CR>

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

" Smarter files opening {{{
" Resolve file extensions when requred when on filename pressing `gf`
augroup suffixes
  autocmd!

  let associations = [
    \ ["javascript", ".js,.json"],
    \ ["python", ".py"],
    \ ["ruby", ".rb"]
  \ ]

  for ft in associations
    execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
  endfor
augroup END
" }}}

" Ctags support {{{
function! GetProjectFolderPath()
  let result = system('git rev-parse --show-toplevel')
  return substitute(result, "\n", "", "")
endfunction

" Force to look for ctags file in your project .git/tags
let ctags_path = GetProjectFolderPath() . '/.git/tags'
let &tag = ctags_path
set notagrelative
" }}}

" VIM Outliner plugin settings {{{
autocmd BufEnter *.otl setlocal foldlevel=0
autocmd BufEnter *.otl setlocal textwidth=80
autocmd BufEnter *.otl setlocal wrap
autocmd BufEnter *.otl setlocal foldenable

autocmd! BufRead,BufNewFile *.otl setfiletype vo_base
autocmd BufRead,BufNewFile *.otl filetype plugin indent on
autocmd BufRead,BufNewFile *.otl setlocal nolist

nmap <leader>ww :tabnew ~/Work/asmeniniai/project-management/index.otl<CR>
" }}}

" VIM Smooth Scroll plugin settings {{{
nnoremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 2)<CR>
nnoremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 2)<CR>
set scrolloff=3
" }}}

" VIM Nerd commenter plugin settings {{{
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign = 'left'
" }}}

" VIM Surround plugin settings {{{
let g:surround_{char2nr('„')} = "„\r“"
" }}}

" VIM Vue plugin settings {{{
let g:vue_pre_processors = ['scss']
autocmd FileType vue syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript
" }}}

" VIM ALE plugin settings {{{
" Show nice customer marking for errors
let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"
highlight ALEErrorSign ctermfg=9 ctermbg=none
highlight ALEWarningSign ctermfg=11 ctermbg=none

" Only filetypes that should be linted automatically on save
" let g:ale_fixers = {
" \   '*': ['remove_trailing_lines', 'trim_whitespace'],
" \}
" let g:ale_linters_explicit = 0
" let g:ale_fix_on_save = 0

let g:ale_fixers = {
\  'javascript': ['prettier'],
\  'json': ['prettier'],
\  'css': ['prettier'],
\  'scss': ['prettier'],
\  'html': ['prettier'],
\  'xml': ['prettier'],
\}

let g:ale_fix_on_save = 1

" }}}

" VIM onedark.vim plugin settings {{{
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
" }}}

" VIM FZF plugin settings {{{
let g:fzf_layout = { 'down': '~35%' }
let g:fzf_preview_window = []

map <leader>/ :Rg <CR>
map // :BLines <CR>
map <leader>f :GFiles<CR>
map <leader>F :Files<CR>
map <leader>b :Buffers<CR>
map <leader>m :Marks<CR>

" Fix for `Rg` command including file name in search options
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --glob '!*.lock' --glob '!*.log' --glob '!*.css' --glob '!.json' ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" }}}

" VIM Prettier plugin settings {{{
let g:prettier#exec_cmd_async = 1
let g:prettier#quickfix_enabled = 1
let g:prettier#quickfix_auto_focus = 0
" }}}

" VIM Deoplete plugin settings {{{
let g:deoplete#enable_at_startup = 1

" Snippets automcompletion
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

let g:neosnippet#snippets_directory = "~/.vim-snippets"
let g:neosnippet#disable_runtime_snippets = {'_' : 1}
let g:neosnippet#enable_snipmate_compatibility = 0
" }}}

" VIM Visual Multi plugin settings {{{
map <M-Up>   <Plug>(VM-Add-Cursor-Up)
map <M-Down> <Plug>(VM-Add-Cursor-Down)
" }}}
