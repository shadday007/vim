vim9script

if exists("g:loaded_tabline_plugin")
  finish
endif

g:loaded_tabline_plugin = 1

logger#Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

import autoload "tabline.vim"

if has('windows')
  set tal=%!MyTabLine()
endif

if has('autocmd')
  augroup tabline
    autocmd!
    autocmd ColorScheme * tabline.Update_highlight()
  augroup END
endif

