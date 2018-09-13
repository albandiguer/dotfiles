set nocompatible

" add runtime paths
set rtp+=~/.vim/bundle/Vundle.vim/
set rtp+=/usr/local/opt/fzf

set shell=/bin/zsh " set shell

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                  " required

" initialize Vundle
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Handle addons
Plugin 'MarcWeber/vim-addon-manager'

" IDE
Plugin 'ap/vim-buftabline' "Display buffers up there
Plugin 'schickling/vim-bufonly' "Close inactive buffers
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'Valloric/YouCompleteMe' " AutoComplete
Plugin 'marijnh/tern_for_vim' "provides Tern-based JavaScript editing support.
Plugin 'ntpeters/vim-better-whitespace' "Strip white spaces
Plugin 'vim-ruby/vim-ruby' "Ruby omnicompletion
Plugin 'tpope/vim-rails' "Extract partials etc, :Alternate, :R
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'skwp/greplace.vim' " Gsearch and Greplace
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim' " Auth in vim, used by gist-vim
Plugin 'mattn/emmet-vim' " Emmet html markup generation
Plugin 'w0rp/ale' " Syntax checker https://vimawesome.com/plugin/ale
Plugin 'scrooloose/nerdtree'
Plugin 'jgdavey/tslime.vim' "send portion of text from a vim buffer to a running tmux session
Plugin 'christoomey/vim-tmux-navigator' "navigate seamlessly between vim and tmux
Plugin 'jgdavey/vim-turbux' "Ruby tests
Bundle 'ervandew/supertab'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tmhedberg/matchit' " Jump to end of block
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'Quramy/tsuquyomi' " Typescript intellisense support
Plugin 'junegunn/fzf.vim' " fuzzy search
Plugin 'mileszs/ack.vim'
Plugin 'metakirby5/codi.vim' " scratchpad, evaluates and print result

" Faster typing
Plugin 'tpope/vim-surround'
Plugin 'Raimondi/delimitMate' " Close parenthesis quotes etc

" Languages packs
Plugin 'sheerun/vim-polyglot'

" Colors
" Plugin 'KevinGoodsell/vim-csexact' "Gvim colorschemes
Plugin 'acarapetis/vim-colors-github'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'junegunn/seoul256.vim'
Plugin 'morhetz/gruvbox'
Plugin 'mswift42/vim-themes'
Plugin 'romainl/Apprentice'
Plugin 'vim-scripts/saturn.vim'
Plugin 'vim-scripts/swamplight'
Plugin 'rakr/vim-one'
Plugin 'joshdick/onedark.vim'
Plugin 'ciaranm/inkpot'

call vundle#end()            " required

filetype plugin indent on    " required, enable the ft plugin

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ttyfast " speed up redraws
set lazyredraw " speed up redraws
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
set number " display number line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType make setlocal noexpandtab
  autocmd FileType python set sw=2 sts=2 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass
  autocmd BufNewFile,BufRead *.ejs set filetype=html

  autocmd BufRead *.md  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()
augroup END

" autocmd BufNewFile,BufRead *.json setlocal syntax=javascript

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" THEME
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
syntax on
set colorcolumn=80
set termguicolors

if has('gui_running')
  autocmd! GUIEnter * set vb t_vb=
  set guifont=Monaco:h11
  colorscheme hybrid
  " remove scroll bars and tool bar
  set guioptions-=r
  set guioptions-=L
  set guioptions-=T
else
  " set termguicolors
  let g:seoul256_background = 233
  set background=light
  colorscheme scheakur
endif

highlight Comment gui=italic
highlight Comment cterm=italic
highlight htmlArg gui=italic
highlight htmlArg cterm=italic

let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" copy in the system clipboard
map <leader>y "*y
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Insert a hash rocket with <c-l>
imap <c-l> <space>=>
imap <c-k> <space>->
imap <c-j> <space><-
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" REMOVE ARROW KEYS USE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

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
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This use vimux and turbux and vim-rails
let g:VimuxUseNearestPane = 1
let g:turbux_runner = 'tslime'
let g:no_turbux_mappings = 1
map <leader>m <Plug>SendTestToTmux
map <leader>M <Plug>SendFocusedTestToTmux
let g:turbux_command_rspec = 'rspec'
let g:turbux_command_typescript='yarn test' " no good, work on it

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Md5 COMMAND
" Show the MD5 of the current buffer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -range Md5 :echo system('echo '.shellescape(join(getline(<line1>, <line2>), '\n')) . '| md5')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" InsertTime COMMAND
" Insert the current time
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gist config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:github_user='alban.diguer@gmail.com'

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
" FZF config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ; :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>r :Tags<CR>

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
" VIM-DISPATCH
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>d :Dispatch<CR>
nnoremap <leader>D :Dispatch!<CR>
autocmd FileType javascript let b:dispatch = 'node %'
autocmd FileType ruby let b:dispatch = 'rspec %'
autocmd FileType typescript let b:dispatch = 'npm run test %'
autocmd FileType python let b:dispatch = 'python %'
" %:t:r current file without extension  (.hs)binding
autocmd FileType haskell let b:dispatch = 'make TARGET=%:t:r'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE syntax checkers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable completion where available.
let g:ale_completion_enabled = 0
let g:ale_echo_cursor = 0 " fasten things a lot (see vim profile)
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--no-semi --single-quote'
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_lint_delay = 0 " 300 (in ms)
let g:ale_lint_on_enter = 0 " on opening a file
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_open_list=0
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠ '
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_linters = {}
let g:ale_linters.javascript = ['eslint']
let g:ale_linters.typescript = ['tsserver', 'tslint']
let g:ale_linters.python = ['flake8']
let g:ale_fixers = {}
" let g:ale_fixers.javascript = ['eslint']
let g:ale_fixers.javascript = ['prettier']
let g:ale_fixers.typescript = ['prettier']
let g:ale_fixers.haskell = ['brittany']
let g:ale_fixers.python = ['black'] " mypy fixer would be great here
" let g:ale_fixers = ['prettier', 'brittany']
" let g:ale_fixers.html = ['prettier']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YCM ultisnips etc.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" https://github.com/honza/vim-snippets
" assuming you want to use snipmate snippet engine
" ActivateAddons vim-snippets snipmate
call vam#ActivateAddons(['vim-snippets', 'snipmate'])

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove trailing whitespace
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" could also be done via ALEFix generics, see ALEFixSuggest
autocmd BufWritePre * StripWhitespace

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim markdown preview config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vim_markdown_preview_github=1
let vim_markdown_preview_browser='Google Chrome'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tsuquyami config - disable checks
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tsuquyomi_disable_quickfix = 1
let g:tsuquyomi_auto_open = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" some mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ( :lopen<CR>
nmap ) :lclose<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Codi syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:codi#interpreters = {
    \ 'haskell': {
      \ 'bin': ['/usr/local/bin/stack', 'exec',  '--',  'ghci', '-ignore-dot-ghci']
    \ },
  \ }
