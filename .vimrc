" Load plugins {{{
call plug#begin('~/.vim/plugged')

" Plug 'scrooloose/nerdcommenter'
Plug 'tmhedberg/matchit'
Plug 'yuttie/comfortable-motion.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-eunuch'
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
Plug 'nvim-lua/plenary.nvim'                               " Telescope dependency
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }   " File, bufer and other stuff manager

if has('nvim')
  Plug 'neovim/nvim-lspconfig'                  " LSP support
  Plug 'hrsh7th/cmp-nvim-lsp'                   " LSP source support
  Plug 'hrsh7th/cmp-buffer'                     " Autocompletion for words from buffers
  Plug 'hrsh7th/cmp-path'                       " Autocompletion for filepaths
  Plug 'hrsh7th/nvim-cmp'                       " Autocompletion plugin
  Plug 'SirVer/ultisnips'                       " Snippets engine
  Plug 'honza/vim-snippets'                     " Snippet files
  Plug 'quangnguyen30192/cmp-nvim-ultisnips'    " Autocompletion for snippets
  Plug 'numToStr/Comment.nvim'                  " Commenting pluggin
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-lua/plenary.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'MunifTanjim/nui.nvim'
  Plug 'kyazdani42/nvim-web-devicons'           " NvimTree dependency for icons
  Plug 'kyazdani42/nvim-tree.lua'               " File manager, sidebar
  Plug 'folke/noice.nvim'
  Plug 'MunifTanjim/nui.nvim'
endif

call plug#end()
" }}}

" Theme {{{
syntax on

" Allow to quickly show numbers - but usually that is not needed
set nonumber

" Display not printable characters set list		
set list listchars=tab:»»,trail:¶

" Disable poor HTML rendering - not really compatible with HTML5 or
" any frontend JavaScript frameworks
let html_no_rendering = 1

" Theme
let g:onedark_termcolors=256
let g:onedark_color_overrides = {
\ "background": { "gui": "#2F343F", "cterm": "0", "cterm16": "0" },
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

" LSP autocompletion (filled by LSP config LUA file below)
set completeopt=menu,menuone,noselect
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
set foldenable
set foldcolumn=0
set foldlevel=9999
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

" Copy filename to clipboard
nnor ,cf :let @*=expand("%")<CR>

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
set wildignore+=*.swp,*.bak,*.pyc,*.pyo,*.so,*~,*.zip,*.gz,*.tar,*.png,*.webp,node_modules/,tmp/,_site/,cache/
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

" Common file types {{{
autocmd BufRead,BufNewFile .czrc setfiletype json
autocmd BufRead,BufNewFile .huskyrc setfiletype json
autocmd BufRead,BufNewFile *.rabl setfiletype ruby
autocmd BufRead,BufNewFile *.njk setfiletype html
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

" Load LSP and other Lua configs {{{
if has('nvim')
  luafile ~/.vim/lsp.lua

  " Open definition in the new tab with `gJ`, while `gj` configured to open in the same window
  nnoremap gJ <cmd>tab split \| lua vim.lsp.buf.definition()<cr>
endif
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

" Native VIM grep should use rg command {{{
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
" }}}

" Automatically search file name from selection with fuzzy search {{{
" TODO: backport this method to Telscope plugin
function! s:getVisualSelection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)

    if len(lines) == 0
        return ""
    endif

    let lines[-1] = lines[-1][:column_end - (&selection == "inclusive" ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]

    return join(lines, "\n")
endfunction
vnoremap <silent><leader>f <Esc>:FZF -q <C-R>=<SID>getVisualSelection()<CR><CR>
" }}}

" VIM Nvim Tree Plugin Settings {{{
map <leader>t :NvimTreeFindFile<CR>
" }}}

" VIM Noice Plugin Settings {{{
lua require("noice").setup()
" }}}

" VIM Telescope Plugin Settings {{{
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>s <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>F :execute 'Telescope find_files default_text=' . "'" . expand('<cword>')<cr>
nnoremap <leader>w :execute 'Telescope live_grep default_text=' . expand('<cword>')<cr>
" }}}
