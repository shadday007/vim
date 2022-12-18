vim9script

def AutoCommands()

  if has('autocmd')
  
    augroup AutoColorScheme
        autocmd!
        autocmd VimEnter,FocusGained * g:CheckColorScheme() 
    augroup END
  
  endif

enddef

AutoCommands()
