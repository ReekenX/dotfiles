" Load plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'tmhedberg/matchit'
Plug 'yuttie/comfortable-motion.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-eunuch'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'jamessan/vim-gnupg', {'branch': 'main'}
Plug 'jpalardy/vim-slime', {'branch': 'main'}
Plug 'dhruvasagar/vim-table-mode'
Plug 'godlygeek/tabular' " Dependency of `vim-markdown`
Plug 'plasticboy/vim-markdown'
Plug 'djoshea/vim-autoread'
Plug 'tpope/vim-surround'
Plug 'kchmck/vim-coffee-script' " No treesitter configuration yet for coffee script
Plug 'altercation/vim-colors-solarized'
Plug 'ddrscott/vim-side-search'
Plug 'joshdick/onedark.vim', {'branch': 'main'} 

if has('nvim')
  Plug 'hrsh7th/nvim-compe'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Treesitter highlighting
  Plug 'neovim/nvim-lspconfig' " Language Server
endif

call plug#end()
" }}}

" Theme {{{
syntax on

" Allow to quickly show numbers - but usually that is not needed
set nonumber

" Display not printable characters set list
set listchars=tab:»»,trail:·,extends:#,nbsp:·

" Disable poor HTML rendering - not really compatible with HTML5 or
" any frontend JavaScript frameworks
let html_no_rendering = 1

" Theme
let g:onedark_termcolors=16
let g:onedark_color_overrides = {
\ "background": {"gui": "#2F343F", "cterm": "235", "cterm16": "0" },
\ "purple": { "gui": "#C678DF", "cterm": "170", "cterm16": "5" }
\}
colorscheme onedark

" Hide status bar
set noruler
set noshowcmd
set noshowmode
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
set cmdheight=1

" When using :term - start in insert mode
if has('nvim')
  autocmd TermOpen * startinsert
endif
" }}}

" Tabs displays 1 level folder and filename {{{
set tabline=%!TabLine()

function! TabLine()
    let line = ''
    for i in range(tabpagenr('$'))
        let line .= (i+1 == tabpagenr()) ? '%#TabLineSel#' : '%#TabLine#'
        let line .= '%' . (i + 1) . 'T'
        let line .= TabLabel(i + 1)
    endfor
    let line .= '%#TabLineFill#%T'
    return line
endfunction

function! TabLabel(n)
    " Return list of buffer numbers for each window pane open in tab.
    let panelist = tabpagebuflist(a:n)
    " See :help setting-tabline then search MyTabLabel if you want to
    " use use the active window. I use the topmost pane, which let's
    " me rename the tab just by putting a window from a different
    " directory in the first position.
    let filepath = bufname(panelist[0])
    let filename = fnamemodify(filepath, ':t')
    let dirname = fnamemodify(filepath, ':p:h:t')
    return ' ' . dirname. '/' . filename . ' '
endfunction
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
set nofoldenable
set foldcolumn=0
set foldlevel=2
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
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

" Fix copying of lines
nmap Y yy

" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" Save without :w quickly
inoremap jj <ESC>
nmap ww <ESC>:nohl<CR><ESC>:write!<CR>

" Close buffer
nnoremap <c-x> :bd<CR>

" Enter current folder files list
map <leader>e :Ex<CR>

" Copy filename to the clipboard
nmap ,cs :let @*=expand("%")<CR>
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
set wildignore+=virtual/,.virtualenv/,upload/,uploads/,node_modules/,tmp/,_site/,cache/
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
    \ ["javascript", ".js"],
    \ ["python", ".py"],
    \ ["ruby", ".rb"]
  \ ]

  for ft in associations
    execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
  endfor

  " For Javascript replace `@` to src which is most common
  set includeexpr=substitute(v:fname,'^.','src/','g')
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

" Quick jump into code
nnoremap go <C-]>zt
" }}}

" Common file types {{{
autocmd BufRead,BufNewFile .czrc setfiletype json
autocmd BufRead,BufNewFile .huskyrc setfiletype json
autocmd BufRead,BufNewFile *.rabl setfiletype ruby
" }}}

" LSP Configuration {{{
if has('nvim')
  luafile ~/.vim/lsp_config.lua
endif
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

" VIM FZF plugin settings {{{
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_preview_window = ['up:60%']
let $FZF_DEFAULT_COMMAND="rg --files --hidden --no-ignore --glob '!.git' --glob '!*.gpg' --glob '!*.png' --glob '!*.svg' --glob '!*.jpg' --glob '!*.jpeg' --glob '!*.zip' --glob '!node_modules' --glob '!_site' --glob '!.jekyll-cache'"

map <leader>/ :Rg <CR>
map // :BLines <CR>
map <leader>f :Files<CR>
map <leader>b :Buffers<CR>
map <leader>m :Marks<CR>

" Search for word under
command! -bang -nargs=* RgExact
  \ call fzf#vim#grep(
  \   'rg -F --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

nmap <Leader>w :execute 'RgExact ' . expand('<cword>') <Cr>
" }}}

" VIM Visual Multi plugin settings {{{
nmap <M-Down> :<C-u>call vm#commands#add_cursor_down(0, v:count1)<cr>
nmap <M-Up> :<C-u>call vm#commands#add_cursor_up(0, v:count1)<cr>
" }}}

" VIM Easy Motion plugin settings {{{
let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <Space><Space> <Plug>(easymotion-bd-w)
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

" VIM Side Search plugin settings {{{
command! -complete=file -nargs=+ S execute 'SideSearch <args>'
" }}}

" VIM UltiSnips plugin setting {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"
" }}}

" Display folder and filename in tabs {{{
set tabline=%!TabLine()

function! TabLine()
    let line = ''
    for i in range(tabpagenr('$'))
        let line .= (i+1 == tabpagenr()) ? '%#TabLineSel#' : '%#TabLine#'
        let line .= '%' . (i + 1) . 'T'
        let line .= TabLabel(i + 1)
    endfor
    let line .= '%#TabLineFill#%T'
    return line
endfunction

function! TabLabel(n)
    " Return list of buffer numbers for each window pane open in tab.
    let panelist = tabpagebuflist(a:n)
    " See :help setting-tabline then search MyTabLabel if you want to
    " use use the active window. I use the topmost pane, which let's
    " me rename the tab just by putting a window from a different
    " directory in the first position.
    let filepath = bufname(panelist[0])
    let filename = fnamemodify(filepath, ':t')
    let dirname = fnamemodify(filepath, ':p:h:t')
    return ' ' . dirname. '/' . filename . ' '
endfunction
" }}}
