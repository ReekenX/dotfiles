" Load plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'vimoutliner/vimoutliner'
Plug 'tmhedberg/matchit'
Plug 'ReekenX/vim-rename2'
Plug 'terryma/vim-smooth-scroll'
Plug 'terryma/vim-multiple-cursors'
Plug 'editorconfig/editorconfig-vim'
Plug 'webdevel/tabulous'
Plug 'posva/vim-vue'
Plug 'cakebaker/scss-syntax.vim'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-surround'
Plug 'djoshea/vim-autoread'
Plug 'dense-analysis/ale'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
if executable('node')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif
Plug 'joshdick/onedark.vim'

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
hi ColorColumn ctermbg=237
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
nmap ww <ESC>:write<CR>

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

" Status bar {{{
" set statusline=
" set statusline+=%#PmenuSel#
" set statusline+=\%f
" set statusline+=%=
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
" set statusline+=\ \|
" set statusline+=\ %{&fileformat}
" set statusline+=\ \|
" set statusline+=\ %l:%c
" set statusline+=\
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

" VIM COC plugin settings {{{
" Use TAB for autocompletion
" Note: Edit snippets for current file with - CocCommand snippets.editSnippets
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

set hidden

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" }}}

" VIM ALE plugin settings {{{
" Show nice customer marking for errors
let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"
highlight ALEErrorSign ctermfg=9 ctermbg=15 guifg=#C30500 guibg=#F5F5F5
highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#ED6237 guibg=#F5F5F5

" Only filetypes that should be linted automatically on save
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'ruby': ['rubocop'],
\}
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
" }}}

" VIM NERDTree plugin settings {{{
nmap ,n :NERDTreeFind<CR>
nmap ,m :NERDTreeToggle<CR>
" }}}

" VIM onedark.vim plugin settings {{{
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
" }}}

" VIM Ranbow plugin settings {{{
au FileType javascript call rainbow#load()
" }}}

" VIM FZF plugin settings {{{
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_preview_window = []

nnoremap <leader>/ :Rg <CR>
nnoremap // :BLines <CR>
map <leader>b :Buffers<CR>
map <leader>f :GFiles<CR>
map <leader>m :Marks<CR>

" Fix for `Rg` command including file name in search options
command! -bang -nargs=* Rg call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
" }}}
