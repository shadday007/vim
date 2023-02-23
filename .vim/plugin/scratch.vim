vim9script

g:scratch_no_mappings = 1

g:scratch_persistence_file = '~/Dropbox/notes/scratch/scratch.md'

nmap <leader>gs <plug>(scratch-insert-reuse)
nmap <leader>gS <plug>(scratch-insert-clear)
xmap <leader>gs <plug>(scratch-selection-reuse)
xmap <leader>gS <plug>(scratch-selection-clear)


