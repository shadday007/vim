vim9script

if exists('g:loaded_autocommands_plugin')
  finish
endif

g:loaded_autocommands_plugin = 1

import autoload "statusline.vim"

def AutoCommands()

  if has('autocmd')

    augroup AutoColorScheme
      autocmd!
      autocmd VimEnter,FocusGained * g:CheckColorScheme() 
    augroup END

  endif

enddef

AutoCommands()
