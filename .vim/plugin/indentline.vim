vim9script

logger#Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))
# indentLine will overwrite 'conceal' color with grey by default. If you want to highlight conceal color with your colorscheme, disable by:
# let g:indentLine_setColors = 0

# Change Indent Char
# Vim and GVim
g:indentLine_char = '▏'
