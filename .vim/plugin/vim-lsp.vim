vim9script

g:lsp_diagnostics_enabled = 1
g:lsp_diagnostics_echo_cursor = 1
g:lsp_diagnostics_float_cursor = 1
g:lsp_semantic_enabled = 1

g:lsp_completion_documentation_enabled = 1
g:lsp_completion_documentation_delay = 1000

# Move notification messages to the right
g:lsp_diagnostics_virtual_text_enabled = 0

# Gutter symbols
g:lsp_document_code_action_signs_enabled = 1
g:lsp_document_code_action_signs_hint = {'text': '→'}
g:lsp_diagnostics_signs_error = {'text': '⨉'}
g:lsp_diagnostics_signs_warning = {'text': '‼'}
g:lsp_diagnostics_signs_info = {'text': 'ℹ'}
g:lsp_diagnostics_signs_hint = {'text': '?'}
g:lsp_diagnostics_signs_insert_mode_enabled = 0 # Please don't bother me while I type

def On_lsp_buffer_enabled()
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc')
      setlocal tagfunc=lsp#tagfunc
    endif
    nmap <buffer> <leader>gA <plug>(lsp-code-action-float)
    nmap <buffer> <leader>gd <plug>(lsp-definition)
    nmap <buffer> <leader>gs <plug>(lsp-document-symbol-search)
    nmap <buffer> <leader>gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> <leader>gr <plug>(lsp-references)
    nmap <buffer> <leader>gi <plug>(lsp-implementation)
    nmap <buffer> <leader>gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
enddef

augroup lsp_install
    au!
    # call on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled On_lsp_buffer_enabled()
augroup END
