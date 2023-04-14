"  coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-simple-react-snippets',
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-prettier',
  \ 'coc-json',
  \ ]
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
