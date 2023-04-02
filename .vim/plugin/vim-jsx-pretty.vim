vim9script

if exists("g:loaded_jsx_pretty_plugin")
  finish
endif

g:loaded_jsx_pretty_plugin = 1

logger#Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

g:vim_jsx_pretty_colorful_config = 1 # default 0

