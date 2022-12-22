vim9script

def g:CheckColorScheme()

  if !has('termguicolors')
    g:base16colorspace = 256
  endif

  if filereadable(expand("~/.vim/vimrc-colorscheme.vim"))
    runtime ~/.vim/vimrc-colorscheme.vim
  endif

  highlight CursorLineNR cterm=bold

enddef
