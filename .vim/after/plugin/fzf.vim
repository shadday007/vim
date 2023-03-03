vim9script

if !exists('g:loaded_fzf')
    finish
endif

# Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

# File path completion in Insert mode using fzf
# Enhance native <C-x> insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-buffer-line)

# Word completion with custom spec with popup layout option
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})

# Mappings
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>F :Files /<CR>
nnoremap <silent> <leader>m :Mru<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <leader>` :Marks<CR>
nnoremap <silent> <leader>; :Commands<CR>
nnoremap <silent> <leader>] :BTags<CR> # NOTE: BTags generates tags for the current buffer on a fly despite having project-wide 'tags'
nnoremap <silent> <leader>} :Tags<CR>
nnoremap <silent> <F1>      :Helptags<CR>
inoremap <silent> <F1> <ESC>:Helptags<CR>
cnoremap <silent> <expr> <C-p> getcmdtype() == ":" ? "<C-u>:History:\<CR>" : "\<ESC>:History/\<CR>"
cnoremap <silent> <C-_> <C-u>:Commands<CR>

# MRU files. Adopted from 'pbogut/fzf-mru.vim'
# Native's "v:oldfiles" does not work, since v:oldfiles is read only on Vim startup
command! Mru call fzf#run(fzf#wrap(fzf#vim#with_preview({ 'source':  fzf_mru#mrufiles#source(), 'options': ['--preview-window', 'noborder', '-m', '--prompt', 'MRU> ', '+s', '--preview-window', 'right:50%' ] })))

command! -nargs=0 RefreshMru call fzf_mru#mrufiles#refresh()

# Override 'Commands' command to fuzzy search only by 2nd column (command name)
# <Enter> to pick command but not execute, <C-x> to execute immediately
command! -nargs=0 Commands call fzf#vim#commands({ 'options': ['--nth', '2'] })
