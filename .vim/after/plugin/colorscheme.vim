vim9script

def g:CheckColorScheme()

  if !has('termguicolors')
    g:base16colorspace = 256
  endif

  if exists('g:load_this_colorscheme ')
    execute 'colorscheme ' ..  g:load_this_colorscheme.colorscheme
    execute 'set background=' .. g:load_this_colorscheme.background
  else
    if filereadable(expand("~/.vim/vimrc-colorscheme.vim"))
      runtime vimrc-colorscheme.vim
    endif
  endif

  doautocmd ColorScheme

  highlight CursorLineNR cterm=bold
  highlight Normal guibg=NONE ctermbg=NONE

enddef

if has('autocmd')

  augroup AutoColorScheme
    autocmd!
    autocmd VimEnter,FocusGained * g:CheckColorScheme()
  augroup END

endif

