"autocmd!

set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'https://github.com/kien/ctrlp.vim'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'pangloss/vim-javascript'
Bundle 'Raimondi/delimitMate'
Bundle 'tpope/vim-commentary'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "scrooloose/nerdtree"
Bundle "milkypostman/vim-togglelist"
Plugin 'itchyny/lightline.vim'
Bundle "fatih/vim-go"
Plugin 'w0rp/ale'
Plugin 'rust-lang/rust.vim'
Plugin 'maralla/completor.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'markonm/traces.vim'

let g:completor_racer_binary = '/Users/mario/.cargo/bin/racer'
let g:completor_complete_options = 'menuone,noselect'

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ }

if executable('rg')
    set grepprg=rg\ --vimgrep
    let g:ctrlp_user_command = 'rg --files %s'
    let g:ctrlp_use_caching = 0
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_switch_buffer = 'et'
endif
set wildignore+=*/vendor,*/vendor/*,*.png,*.jpg,*.gif,build/*,node_modules/*,*.ttf,*/node_modules/*,*/build/*,*/target,*/target/*

let NERDTreeIgnore=['node_modules', 'vendor']

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" go
let g:go_highlight_methods = 1
let g:go_highlight_interfaces= 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:auto_type_info=0
let g:go_auto_sameids=0

let g:go_list_type = "quickfix"

let g:ale_fixers = {'rust': ['rustfmt']}
let g:ale_fix_on_save = 1

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'html': [],
\}

let g:ale_lint_on_enter = 0

let g:omni_sql_no_default_maps = 1

" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
set nocompatible
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" perf stuff
:set lazyredraw
:set ttyfast
:set synmaxcol=128
:set re=1
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
set nocursorline
set nocursorcolumn
set norelativenumber
set cmdheight=1
set switchbuf=useopen
set showtabline=4
set winwidth=79
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
set list
set listchars=tab:⋅\ ,extends:#,trail:⋅,nbsp:⋅
" Enable highlighting for syntax
syntax on
syntax sync minlines=200

filetype plugin indent on

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
let mapleader=","
" Fix slow O inserts
:set timeout timeoutlen=1000 ttimeoutlen=100
" Modelines (comments that set vim options on a per-file basis)
set modeline
set modelines=3
" Turn folding off for real, hopefully
set foldmethod=manual
set nofoldenable
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType go setlocal omnifunc=
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd! BufRead,BufNewFile *.sass setfiletype sass 
augroup END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set t_Co=256 
:set background=dark
colorscheme nazca

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>y "*y
nnoremap <leader>vb :grep! -Q '<c-r><c-w>'<cr>:cw<cr><cr>
nnoremap <leader>vv :grep! "\b<c-r><c-w>\b"<cr>:cw<cr><cr>

nnoremap <leader>c :nohls<cr>

command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap <leader>vf :Ag<SPACE>

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

imap <c-c> <esc>

nnoremap <leader><leader> <c-^>
nnoremap <leader>s :call OpenSplit()<cr>

function! OpenSplit()
  normal! v
endfunction
" Align selected lines
vnoremap <leader>ib :!align<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%

map <leader>n :bn<cr>
map <leader>N :bp<cr>

map <leader>mk :!make test<cr>

map <leader>f :CtrlP<cr>
map <leader>F :CtrlPMRU<cr>
map <leader>t :NERDTreeToggle<CR>
map <leader>T :NERDTreeFind<CR>
map <leader>ust :set softtabstop=2 <bar> :set shiftwidth=2 <bar> :set tabstop=2<cr>
map <leader>et :set expandtab!

" re-sync syntax
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>


""""""""""""""""""""""""""""""""""
" DISABLE ARROW KEYS 
""""""""""""""""""""""""""""""""""
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
map q <nop>

inoremap <Nul> <C-x><C-o>
vnoremap . :normal .<CR>
imap <C-b> <CR><Esc>O

vmap <C-c> "+y
nnoremap <leader>w :w<cr>

set encoding=utf-8

