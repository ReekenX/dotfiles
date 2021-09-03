" Load plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'vimoutliner/vimoutliner'
Plug 'tmhedberg/matchit'
Plug 'yuttie/comfortable-motion.vim'
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
Plug 'joshdick/onedark.vim', {'branch': 'main'}
Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular' " Dependency of `vim-markdown`
Plug 'plasticboy/vim-markdown'
Plug 'jamessan/vim-gnupg', {'branch': 'main'}
Plug 'jpalardy/vim-slime', {'branch': 'main'}
Plug 'dhruvasagar/vim-table-mode'
Plug 'kchmck/vim-coffee-script'
if has('nvim')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'honza/vim-snippets'
endif

call plug#end()
" }}}
"
" Theme {{{
syntax on

" Allow to quickly show numbers - but usually that is not needed
set nonumber
noremap <leader>n :set invnumber<CR>

" Hide any other info
set noruler
set shortmess=F
set noshowcmd
set noshowmode

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

" Show status line always
set laststatus=2
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
set cmdheight=1

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

" Backups and swap file {{{
" Create folders which will be auto removed after OS restart
silent execute '!mkdir -p /tmp/.vim/backup'
silent execute '!mkdir -p /tmp/.vim/undo'

" Setup backups and files prefixing with date
set backup
set backupdir=/tmp/.vim/backup
autocmd BufWritePre * let &bex = '-' . strftime("%Y-%m-%d_%H:%M")

" Swap files are trashing every folder/project
set noswapfile

" Store undo history so it can be restored after VIM is closed
set undofile
set undodir=/tmp/.vim/undo
" }}}

" Folding rules {{{
set foldenable
set foldcolumn=0
set foldmethod=marker
set foldlevel=1

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
" Resolve file extensions when required when on filename pressing `gf`
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

  " For Javascript replace `@` to src which is most common
  set includeexpr=substitute(v:fname,'^.','src/','g')
augroup END

" When `gf` is used for relative files (for example navigating to
" /another/path/b.txt from /some/path/a.txt
set path+=**
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

" Quick jump into code
nnoremap go <C-]>zt
" }}}

" Common file types {{{
autocmd BufRead,BufNewFile .czrc setfiletype json
autocmd BufRead,BufNewFile .huskyrc setfiletype json
" }}}

" VIM Outliner plugin settings {{{
autocmd BufEnter *.otl setlocal foldlevel=0
autocmd BufEnter *.otl setlocal textwidth=80
autocmd BufEnter *.otl setlocal wrap
autocmd BufEnter *.otl setlocal foldenable

autocmd! BufRead,BufNewFile *.otl setfiletype vo_base
autocmd BufRead,BufNewFile *.otl filetype plugin indent on
autocmd BufRead,BufNewFile *.otl setlocal nolist
" }}}

" VIM Smooth Scroll plugin settings {{{
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

" Vim COC plugin integration
let g:ale_disable_lsp = 1

" Only linters listed below are allowed to work
let g:ale_linters_explicit = 1

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['prettier'],
\  'json': ['prettier'],
\  'css': ['prettier'],
\  'scss': ['prettier'],
\  'html': ['prettier'],
\  'xml': ['prettier'],
\}

" Attempt to fix files on save (sometimes annoying)
let g:ale_fix_on_save = 1
" }}}

" VIM Lightline plugin settings {{{
function! LightlineFilename()
  return expand("%:f")
endfunction

" Simplify output in status bar
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
  \   'left': [['readonly', 'filename', 'modified']],
  \   'right': [['lineinfo']]
  \ },
  \ 'component_function': {
  \   'filename': 'LightlineFilename',
  \ },
\ }

" Drop close button from tabs bar
let g:lightline.tabline = {
  \ 'left': [ [ 'tabs' ] ],
  \ 'right': [],
\ }

" Drop black background from the toolbar
autocmd VimEnter * call SetupLightlineColors()
function! SetupLightlineColors() abort
  " transparent background in statusbar
  let l:palette = lightline#palette()

  " let l:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  " let l:palette.inactive.middle = l:palette.normal.middle
  " let l:palette.tabline.middle = l:palette.normal.middle
  " let l:palette.tabline.tabsel = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  " let l:palette.tabline.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  " let l:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]

  let l:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:palette.inactive.middle = l:palette.normal.middle
  let l:palette.tabline.middle = l:palette.normal.middle

  call lightline#colorscheme()
endfunction
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
map <leader>t :Tags<CR>

" Fix for `Rg` command including file name in search options
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --glob '!*.lock' --glob '!*.log' --glob '!*.css' --glob '!.json' ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! GFiles call fzf#run(fzf#wrap({'source': 'git ls-files -- . ":!:*.png" ":!:*.jpg" ":!:*.zip" ":!:*.svg"'}))
" }}}

" VIM Prettier plugin settings {{{
let g:prettier#exec_cmd_async = 1
let g:prettier#quickfix_enabled = 1
let g:prettier#quickfix_auto_focus = 0
" }}}

" " VIM Deoplete plugin settings {{{
" let g:deoplete#enable_at_startup = 1
"
" " Snippets automcompletion
" imap <C-k> <Plug>(neosnippet_expand_or_jump)
" smap <C-k> <Plug>(neosnippet_expand_or_jump)
" xmap <C-k> <Plug>(neosnippet_expand_target)
"
" let g:neosnippet#snippets_directory = "~/.vim/snippets"
" let g:neosnippet#disable_runtime_snippets = {'_' : 1}
" let g:neosnippet#enable_snipmate_compatibility = 0
" " }}}

" VIM Visual Multi plugin settings {{{
nmap <M-Down> :<C-u>call vm#commands#add_cursor_down(0, v:count1)<cr>
nmap <M-Up> :<C-u>call vm#commands#add_cursor_up(0, v:count1)<cr>
" }}}

" VIM Easy Motion plugin settings {{{
let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <Space><Space> <Plug>(easymotion-bd-w)
" }}}

" VIM COC plugin settings {{{
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
" }}}

" VIM Slime plugin settings {{{
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_dont_ask_default = 1
nnoremap <c-c><c-c> :SlimeSendCurrentLine<CR>
" }}}

" VIM Markdown plugin settings {{{
let g:vim_markdown_frontmatter = 1
autocmd BufEnter *.markdown setlocal foldlevel=1
autocmd BufEnter *.markdown setlocal textwidth=80
autocmd BufEnter *.markdown setlocal wrap
" }}}
