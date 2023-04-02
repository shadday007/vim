vim9script

if exists('g:loaded_scratch_plugin')
  finish
endif

g:loaded_scratch_plugin = 1


logger#Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

g:scratch_no_mappings = 1

g:scratch_persistence_file = '~/Dropbox/notes/scratch/scratch.md'

nmap <leader>gs <plug>(scratch-insert-reuse)
nmap <leader>gS <plug>(scratch-insert-clear)
xmap <leader>gs <plug>(scratch-selection-reuse)
xmap <leader>gS <plug>(scratch-selection-clear)


