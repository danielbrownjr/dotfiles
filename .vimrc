"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My .vimrc
" Author: Daniel R Brown Jr.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap options
" Map leader
:let mapleader = "-"
" Map shortcuts
:inoremap jk <esc>
:inoremap <esc> <nop>
:nnoremap <cr> o<esc>
" Edit .vimrc on the fly
:noremap <leader>ev :edit $MYVIMRC<cr>
" edit .bashrc on the fly
:noremap <leader>eb :split ~/.bashrc<cr>
" Source new .vimrc on the fly
:noremap <leader>sv :source $MYVIMRC<cr>
" Swap between splits easily
:noremap <leader>w <c-w>w

" Asthetic improvements
:set relativenumber
