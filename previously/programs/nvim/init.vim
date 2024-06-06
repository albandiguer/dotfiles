colorscheme habamax 

" close all buffers but current https://stackoverflow.com/a/42071865/549563
nnoremap ' :%bd\|e#<CR>

" Clipboard
set clipboard^=unnamed,unnamedplus
"
" when a bracket is inserted, briefly show the matching one
set showmatch

" round misaligned indented code
" https://twitter.com/vim_tricks/status/1545752287192170503
set shiftround

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing extra message when using completion
set shortmess+=c

" Ag the silver searcher
" change the default engine for ack (ack-vim)
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif
" moved to Telescope
" nnoremap K :Ack! "\b<cword>\b"<CR>

" A bit of magic here, see in neovim.nix, the main file is generated by
" concat all lua/* files
lua require('main')

" NOTE test of  https://github.com/autozimu/LanguageClient-neovim/blob/next/INSTALL.md
" let g:LanguageClient_serverCommands = { 'ruby': ['tcp://127.0.0.1:7658'] }
" nnoremap <silent> Y :call LanguageClient#textDocument_hover()<CR>

