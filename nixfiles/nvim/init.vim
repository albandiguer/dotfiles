
" TODO convert vimscript to lua https://github.com/nanotee/nvim-lua-guide/
" neat dotfiles here https://github.com/elianiva/dotfiles
" colorscheme catppuccin " test https://vimcolorschemes.com/yasukotelin/shirotelin
colorscheme grb256
let g:context_nvim_no_redraw = 1
let mapleader=','

" close all buffers but current https://stackoverflow.com/a/42071865/549563
nnoremap ' :%bd\|e#<CR>

" disable ex mode
map Q <Nop>

set clipboard^=unnamed,unnamedplus
" Copy to system clipboard
map <leader>y "+y
imap <C-l> <space>=>
imap <C-k> <space>->
imap <c-c> <esc>

" vim-dispatch
noremap <leader>d :Dispatch<CR>

" switch previous buffer
nnoremap <leader><leader> <c-^>

" select all
map <C-a> <esc>ggVG<CR>
" awesome paste, lets see
xnoremap p pgvy

" easy lopen lclose
" nmap ( :lopen<CR>
" nmap ) :lclose<CR>
nmap ( :Trouble<CR>
nmap ) :TroubleClose<CR>


" https://twitter.com/vim_tricks/status/1545065274369609728
" eselect pasted text with gp
nnoremap gp `[v`]

" when a bracket is inserted, briefly show the matching one
set showmatch

" round misaligned indented code
" https://twitter.com/vim_tricks/status/1545752287192170503
set shiftround

" disable arrow keys and use only ctrl+hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
noremap <c-k> <C-w>k
noremap <c-j> <C-w>j
noremap <c-h> <C-w>h
noremap <c-l> <C-w>l

map <C-n> :NERDTreeToggle<CR>
map <C-b> :NERDTreeFind<CR>
let NERDTreeShowHidden=1
" close vim if only open window is nerdtree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Telescope config
nnoremap <leader>f <cmd>Telescope git_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap ; <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Use <Tab> and <S-Tab> to navigate through popup menu
" NOTE disabled as we want to use copilot as well
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing extra message when using completion
set shortmess+=c

" Ag the silver searcher
" change the default engine for search
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor " Use ag over grep
	" let g:grep_cmd_opts = '--line-numbers --noheading'
	let g:ackprg = 'ag --vimgrep --column'
	" let g:ackprg = 'ag --nogroup --nocolor --column'
endif

" TODO replace with grep (ag), remove Ack
nnoremap K :Ack! "\b<cword>\b" <CR>

lua require('main')
