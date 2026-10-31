" Powerline-style status line using only built-in Vim features.
function! SaraVimMode() abort
    let l:m = mode(1)
    if l:m =~# '^i' | return 'INSERT' | endif
    if l:m =~# '^R' | return 'REPLACE' | endif
    if l:m ==# 'v' | return 'VISUAL' | endif
    if l:m ==# 'V' | return 'V-LINE' | endif
    if l:m ==# "\<C-v>" | return 'V-BLOCK' | endif
    if l:m =~# '^c' | return 'COMMAND' | endif
    if l:m =~# '^t' | return 'TERMINAL' | endif
    return 'NORMAL'
endfunction

function! SaraStatusColors() abort
    highlight SaraMode guifg=#1e1e2e guibg=#cba6f7 gui=bold ctermfg=0 ctermbg=183
    highlight SaraModeEdge guifg=#cba6f7 guibg=#313244 ctermfg=183 ctermbg=236
    highlight SaraFile guifg=#cdd6f4 guibg=#313244 ctermfg=252 ctermbg=236
    highlight SaraFileEdge guifg=#313244 guibg=#1e1e2e ctermfg=236 ctermbg=234
    highlight SaraFill guifg=#a6adc8 guibg=#1e1e2e ctermfg=248 ctermbg=234
    highlight SaraTypeEdge guifg=#89b4fa guibg=#1e1e2e ctermfg=117 ctermbg=234
    highlight SaraType guifg=#1e1e2e guibg=#89b4fa ctermfg=0 ctermbg=117
    highlight SaraPositionEdge guifg=#a6e3a1 guibg=#89b4fa ctermfg=151 ctermbg=117
    highlight SaraPosition guifg=#1e1e2e guibg=#a6e3a1 gui=bold ctermfg=0 ctermbg=151
endfunction
call SaraStatusColors()
augroup sara_statusline
    autocmd!
    autocmd ColorScheme * call SaraStatusColors()
    autocmd ModeChanged * redrawstatus
augroup END
set laststatus=2
set noshowmode
let &statusline = '%#SaraMode# %{SaraVimMode()} %#SaraModeEdge#'
            \ . '%#SaraFile# %<%f %m%r%h %#SaraFileEdge#'
            \ . '%#SaraFill#%='
            \ . '%#SaraTypeEdge#%#SaraType# %{empty(&filetype) ? "text" : &filetype} '
            \ . '%#SaraPositionEdge#%#SaraPosition# %l:%c · %p%% '
