"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My .vimrc
" Author: Daniel R Brown Jr.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic setup
set nocompatible
filetype off

" Remap options
" Map leader
let mapleader = "-"
" Map shortcuts
inoremap jk <esc>
inoremap <esc> <nop>
nnoremap <cr> o<esc>
" Edit .vimrc on the fly
noremap <leader>ev :edit $MYVIMRC<cr>
" edit .bashrc on the fly
noremap <leader>eb :split ~/.bashrc<cr>
" Source new .vimrc on the fly
noremap <leader>sv :source $MYVIMRC<cr>
" edit i3 config easily
noremap <leader>ei3 :split ~/.config/i3/config<cr>
" Swap between splits easily
noremap <leader>w <c-w>w

" Asthetic improvements
set relativenumber
syntax on

" Airline Stuff
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"PLUGINS"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle plugin manager
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Insert plugins here
Plugin 'w0rp/ale'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()
filetype plugin indent on
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

