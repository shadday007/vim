vim9script

if exists("g:loaded_vista_plugin")
  finish
endif

g:loaded_vista_plugin = 1

logger#Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

# How each level is indented and what to prepend.
# This could make the display more compact or more spacious.
# e.g., more compact: ["▸ \", \"\"]
# Note: this option only works for the kind renderer, not the tree renderer.
g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

# Executive used when opening vista sidebar without specifying it.
# See all the avaliable executives via `:echo g:vista#executives`.
g:vista_default_executive = 'ctags'

# " Set the executive for some filetypes explicitly. Use the explicit executive
# " instead of the default one for these filetypes when using `:Vista` without
# " specifying the executive.
# g:vista_executive_for = {
#    'cpp': 'vim_lsp',
#    'php': 'vim_lsp',
#    }

# " Declare the command including the executable and options used to generate ctags output
# " for some certain filetypes.The file path will be appened to your custom command.
# " For example:
# g:vista_ctags_cmd = {
#        'haskell': 'hasktags -x -o - -c',
#        }

# To enable fzf's preview window set g:vista_fzf_preview.
# The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
# For example:
g:vista_fzf_preview = ['right:50%']
# Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
g:vista#renderer#enable_icon = 1

# The default icons can't be suitable for all the filetypes, you can extend it as you wish.
g:vista#renderer#icons = {
  "function": "\uf794",
  "variable": "\uf71b",
}


