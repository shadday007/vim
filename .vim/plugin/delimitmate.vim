vim9script

nnoremap <silent> <Leader>dm :DelimitMateSwitch<CR>
# delimitMate_map                                              *delimitMate_map*

# This |User| event is emittted just prior to delimitMate defining its
# buffer-local key mappings. You can use this command to define your own
# mappings that are disabled when delimitMate is turned off or excludes the
# current filetype.
# >

#     au User delimitMate_map call s:delimitMate_map()
#     function s:delimitMate_map()
#         imap <buffer><expr> <C-Tab> delimitMate#JumpAny()
#     endfunction

# <
# ------------------------------------------------------------------------------
# delimitMate_unmap                                          *delimitMate_unmap*

# This |User| event is emitted just after delimitMate clears its buffer-local
# key mappings. You can use this command to clear your own mappings that you set
# in response to |delimitMate_map|.
# >

#     au User delimitMate_unmap call s:delimitMate_unmap()
#     function s:delimitMate_unmap()
#         silent! iunmap <buffer> <C-Tab>
#     endfunction

# <
# Note: This event may be emitted before |delimitMate_map|, and may be emitted
# multiple times in a row without any intervening |delimitMate_map| events.
