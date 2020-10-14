" vim not vi
set nocompatible

syntax enable
filetype plugin on


" Search down into subfolders
" Provides tab-completion for all file-related
set path+=**

command! MakeTags !ctags -R .

let g:netrw_banner=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" copy in the system clipboard
map <leader>y "*y
" Insert a hash rocket with <c-l>
imap <c-l> <space>=>
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" ESC = <c-c> in insert mode
imap <c-c> <esc>
" Clear the search buffer when hitting return
nnoremap <cr> :nohlsearch<cr>
" switch previous buffer
nnoremap <leader><leader> <c-^>
" select all
map <C-a> <esc>ggVG<CR>
" awesome paste
xnoremap p pgvy

let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

nmap ( :lopen<CR>
nmap ) :lclose<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" REMOVE ARROW KEYS USE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS - PLUG VIM
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'ntpeters/vim-better-whitespace' "Strip white spaces
Plug 'MattesGroeger/vim-bookmarks'
Plug 'w0rp/ale' " Syntax checker https://vimawesome.com/plugin/ale
Plug 'christoomey/vim-tmux-navigator' "navigate seamlessly between vim and tmux
Plug 'Raimondi/delimitMate' " Close parenthesis quotes etc
Plug 'tpope/vim-commentary'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " fuzzy search

Plug 'schickling/vim-bufonly' "Close inactive buffers
Plug 'mileszs/ack.vim'
Plug 'sheerun/vim-polyglot'
Plug 'heavenshell/vim-jsdoc', { 'do': 'make install', 'for': ['javascript', 'typescript', 'javascript.jsx']}
Plug 'tmhedberg/matchit' " Jump to end of block
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'scrooloose/nerdtree'
Plug 'mattn/webapi-vim' " Auth in vim, used by gist-vim
Plug 'mattn/gist-vim'


Plug 'lodestone/lodestone.vim' " colorscheme

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set ttyfast " speed up redraws
" set lazyredraw " speed up redraws
set hidden " allow unsaved background buffers and remember marks/undo for them
set history=10000 " remember more commands and search history
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set laststatus=2
set showmatch " when a bracket is inserted, briefly show the matching one
set incsearch
set hlsearch
set ttimeout
set ttimeoutlen=250
set notimeout
set ignorecase smartcase " make searches case-sensitive only if they contain upper-case characters
set cmdheight=2 " highlight current line
set switchbuf=useopen
set numberwidth=5 " number of columns used for line number display
set showtabline=2
set winwidth=79
set nocursorline
set scrolloff=3 " keep more context when scrolling off the end of a buffer
set backup " Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/* " do not backup files for those patterns
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set showcmd " display incomplete commands
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list:longest
set wildmenu " make tab completion for files/buffers act like bash
let mapleader=","
map Q <Nop> " disable Ex mode
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
" set t_ti= t_te=
" set number " display number line
set relativenumber


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" REMOVE ARROW KEYS USE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE syntax checkers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:ale_completion_delay=200
let g:ale_completion_enabled = 0
let g:ale_echo_cursor = 0 " fasten things a lot (see vim profile)
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--no-semi --single-quote'
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_lint_delay = 200 " (in ms)
let g:ale_lint_on_enter = 0 " on opening a file
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_open_list=0
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠ '
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'typescript': ['tsserver', 'tslint'],
      \ 'python': ['flake8'],
      \ 'sql': ['sqlint'],
      \ 'terraform': ['tflint']
      \ }
let g:ale_fixers = {
      \ 'javascript': ['eslint'],
      \ 'typescript': ['prettier'],
      \ 'html': ['prettier'],
      \ 'markdown': ['prettier'],
      \ 'haskell': ['brittany'],
      \ 'python': ['black'],
      \ 'sql': ['sqlfmt'],
      \ 'terraform': ['fmt'],
      \ '*': ['remove_trailing_lines', 'trim_whitespace']
      \ }
let g:ale_python_black_options = '--line-length 79' " line length 88 by default


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ; :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>b :Buffers<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bufonly config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ' :Bonly<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ag the silver searcher
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" change the default engine for search
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor " Use ag over grep
  let g:grep_cmd_opts = '--line-numbers --noheading'
  let g:ackprg = 'ag --vimgrep'
  " let g:ackprg = 'ag --nogroup --nocolor --column'
endif"

nnoremap K :Ack! "\b<cword>\b" <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Nerdtree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open nerdtree
map <C-n> :NERDTreeToggle<CR>
map <C-b> :NERDTreeFind<CR>
let NERDTreeShowHidden=1
" close vim if only open window is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM MARKDOWN PREVIEW
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vim_markdown_preview_github=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COMPLETION CONFIG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colorscheme lodestone
