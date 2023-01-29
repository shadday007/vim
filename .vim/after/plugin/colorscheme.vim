vim9script

def g:CheckColorScheme()

  if !has('termguicolors')
    g:base16colorspace = 256
  endif

  if filereadable(expand("~/.vim/vimrc-colorscheme.vim"))
    runtime vimrc-colorscheme.vim
  endif

  doautocmd ColorScheme

  highlight CursorLineNR cterm=bold

enddef

if has('autocmd')

  augroup AutoColorScheme
    autocmd!
    autocmd SigUSR1,VimEnter,FocusGained * g:CheckColorScheme()
  augroup END

endif

