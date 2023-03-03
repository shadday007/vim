" Functions to enable to gvim to change font size, note that the type font must
" be installed on system
" let s:fnt_types = ['JetBrainsMono\ Nerd\ Font', 'JetBrainsMono\ Nerd\ Font', 'JetBrainsMono\ Nerd\ Font', 'JetBrainsMono\ Nerd\ Font', 'JetBrainsMono\ Nerd\ Font'   ]
let s:fnt_types = ['Fira\ code', 'Fira\ code', 'Fira\ code', 'Fira\ code', 'Fira\ code'   ]
let s:fnt_sizes = [ 14, 16, 18 ,20 , 22]


let g:fnt_index = 0
let g:fnt_size  = s:fnt_sizes[g:fnt_index]

function! fonts#CycleFont()
    let g:fnt_index = (g:fnt_index + 1) % len(s:fnt_types)
    let g:fnt_size  = s:fnt_sizes[g:fnt_index]
    call fonts#ResetFont()
endfunction

function! fonts#ResetFont ()
    if has("gui_running")
        exe ':set guifont=' . s:fnt_types[g:fnt_index] . '\ ' . string(g:fnt_size)
    endif
endfunction

function! fonts#FontSizePlus ()
    let g:fnt_size = g:fnt_size + 0.5
    call fonts#ResetFont()
endfunction

function! fonts#FontSizeMinus ()
    let g:fnt_size = g:fnt_size - 0.5
    call fonts#ResetFont()
endfunction

