""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
" alternatively, pass a path where Vundle should install bundles
"let path = '~/some/path/here'
"call vundle#rc(path)

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep bundle commands between here and filetype plugin indent on.
" scripts on GitHub repos
" Plugin 'wincent/command-t'
" When command-t breaks because of ruby version, 
" check version in vim :ruby puts "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
" rbenv shell version
" cd ~/.vim/bundle/command-t/ruby/command-t
" ruby extconf.rb
" make

Plugin 'bling/vim-airline'
Plugin 'wookiehangover/jshint.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'Raimondi/delimitMate'
Plugin 'Valloric/YouCompleteMe'
Plugin 'acarapetis/vim-colors-github'
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'garbas/vim-snipmate'
Plugin 'hallison/vim-markdown'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'jgdavey/vim-turbux'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'marijnh/tern_for_vim'
Plugin 'mattn/emmet-vim'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'mileszs/ack.vim'
Plugin 'othree/html5.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'skwp/greplace.vim'
Plugin 'tmhedberg/matchit'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails.git'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/closetag.vim'
Plugin 'xolox/vim-misc'
Plugin 'slim-template/vim-slim'
Plugin 'KevinGoodsell/vim-csexact'
Plugin 'vim-scripts/BufOnly.vim'
Plugin 'bronson/vim-trailing-whitespace'
" Colors 
" 
Plugin 'junegunn/seoul256.vim'
Plugin 'vim-scripts/swamplight'
Plugin 'vim-scripts/saturn.vim'
Plugin 'vim-scripts/khaki.vim'
Plugin 'stulzer/heroku-colorscheme'
Plugin 'Donearm/Laederon'
Plugin 'mtglsk/wikipedia.vim'

let g:seoul256_background = 233

call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cmdheight=2
set switchbuf=useopen
set numberwidth=5
set showtabline=2
set winwidth=79
set nocursorline
" This makes RVM work inside Vim. I have no idea why.
" set shell=bash
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
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
let mapleader=","
" disable Ex mode
map Q <Nop>

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
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass 

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Indent p tags
  " autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()
augroup END

" added for handlebars syntax highlighting 
" see http://www.vim.org/scripts/script.php?script_id=3638
au BufRead,BufNewFile *.handlebars,*.hbs set ft=handlebars

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"hi clear
"if exists("syntax_on")
"  syntax reset
"endif
syntax enable
syntax on
:set t_Co=256

set colorcolumn=80
if has('gui_running') 
    set guifont=Droid\ Sans\ Mono:h14
    " :set fu " fullscreen

    "h80 sorcerer githu bkhaki 
    colorscheme slate
else
    "grb256 xoria256 busierbee seoul256 baycomb vivichalk
    " colorscheme grb256
<<<<<<< HEAD
    colorscheme vividchalk
    colorscheme vividchalk
=======
    colorscheme seoul256
    " colorscheme vividchalk
>>>>>>> Disable cursorline
endif
hi ColorColumn ctermbg=233 guibg=#eeeeee
" hi StatusLine ctermbg=93 ctermfg=254
hi StatusLine ctermbg=57 ctermfg=255
:set nu
" remove scroll bars and tool bar
:set guioptions-=r
:set guioptions-=L
:set guioptions-=T
" expand width in fullscreen 
" hide tab bar
set showtabline=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE POWERLINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :let g:Powerline_symbols = 'unicode'
" :set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%) 
" set rtp+=/Users/adiguer/.vim/bundle/powerline/powerline/bindings/vim
" call vam#ActivateAddons(['powerline'])

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>y "*y
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>
" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>
" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()
nnoremap <leader><leader> <c-^>
" Menu for the buffers
nnoremap <F5> :buffers<CR>:buffer<space>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
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
" MAPS TO JUMP TO SPECIFIC COMMAND-T TARGETS AND FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>gr :topleft :split config/routes.rb<cr>
function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 50 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>
" map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
" map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
" map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
" map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
" map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
" map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
" map <leader>gs :CommandTFlush<cr>\|:CommandT public/stylesheets/sass<cr>
" map <leader>gf :CommandTFlush<cr>\|:CommandT features<cr>
" map <leader>gg :topleft 30 :split Gemfile<cr>
" map <leader>gt :CommandTFlush<cr>\|:CommandTTag<cr>
" map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
" map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use vim-rails from now :R :A

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This use vimux and turbux and vim-rails
let g:no_turbux_mappings = 1
map <leader>m <Plug>SendTestToTmux
map <leader>M <Plug>SendFocusedTestToTmux

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Md5 COMMAND
" Show the MD5 of the current buffer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -range Md5 :echo system('echo '.shellescape(join(getline(<line1>, <line2>), '\n')) . '| md5')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" InsertTime COMMAND
" Insert the current time
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Selecta
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
" function! SelectaCommand(choice_command, selecta_args, vim_command)
"     try
"         silent let selection = system(a:choice_command . " | selecta " . a:selecta_args)
"     catch /Vim:Interrupt/
"         " Swallow the ^C so that the redraw below happens; otherwise there
"         " will be leftovers from selecta on the screen 
"         redraw!
"         return
"     endtry
"     redraw!
"     exec a:vim_command . " " . selection
" endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
" nnoremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command-T: ignore stuff that can't be opened, and generated files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildignore =*.png,*.PNG,*.JPG,*.jpg,*.GIF,*.gif,*.pdf,*.jpeg,tmp/**,rdoc/**,spec/dummy/**,log/**,*.log,*.pdf,bin/**,*.ico

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coffeescript vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gist
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:github_user='albandiguer'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Prettify json
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.json setlocal syntax=javascript

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
" Custom note
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:let g:VN_DefaultDir = "~/Documents/Notes" 
:let g:notes_directories = ['~/Documents/Notes', '~/Dropbox/Shared Notes']
:let g:notes_tab_indents = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Edit crontab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backupskip=/tmp/*,/private/tmp/*

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cache ctrlp in the disk for future use
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

" unlet g:ctrlp_custom_ignore
" this will be used by default seracher, not with a custom one like ag silver
" searcher
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.capistrano$\|db$\|bin$\|node_modules$\|tmp$\|vendor$',
    \ 'file': '\.woff$\|\.so$\|\.svg$\|\.ttf$\|\.eot$\|\.markdown$\|\.png$'
    \ }

" change the default engine for search
" brew install ag
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" define the folders to ignore 
let g:ctrlp_map = '<leader>f'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set zsh as my term
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shell=/bin/zsh

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TagBar 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-m> :TagbarToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PRY Debug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:ia pry require 'pry'; binding.pry

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dispatch things tpope/vim-dispatch
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd FileType javascript let b:dispatch = 'node %'
" autocmd FileType ruby let b:dispatch = 'node %'
" nnoremap <leader>d :Dispatch<CR>

" awesome paste
xnoremap p pgvy
" select all
map <C-a> <esc>ggVG<CR>

" use system clipboard and paste easy everywhere.
set clipboard=unnamed

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_tidy_ignore_errors = ['proprietary attribute "ng-', 'is not recognized!', 'discarding unexpected']

