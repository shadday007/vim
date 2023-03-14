vim9script

def g:CheckColorScheme()

  if !has('termguicolors')
    g:base16colorspace = 256
  endif

  if exists('g:load_this_colorscheme ')
    execute 'set background=' .. g:load_this_colorscheme.background
    execute 'colorscheme ' ..  g:load_this_colorscheme.colorscheme
  else
    if filereadable(expand("~/.vim/vimrc-colorscheme.vim"))
      runtime vimrc-colorscheme.vim
    endif
  endif

  doautocmd ColorScheme

  highlight CursorLineNR cterm=bold

  if get(g:, 'background_transparent', false) && !has('gui_running')
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NonText ctermbg=NONE guibg=NONE
  endif

  highlight SpellBad   term=underline cterm=underline ctermfg=4 ctermbg=NONE gui=undercurl guisp=#fc514e
  highlight SpellCap   term=underline cterm=underline ctermfg=5 ctermbg=NONE gui=undercurl guisp=#82aaff
  highlight SpellRare  term=underline cterm=underline ctermfg=6 ctermbg=NONE gui=undercurl guisp=#e3d18a
  highlight SpellLocal term=underline cterm=underline ctermfg=6 ctermbg=NONE gui=undercurl guisp=#82aaff
enddef

if has('autocmd')

  augroup AutoColorScheme
    autocmd!
    autocmd VimEnter,FocusGained * g:CheckColorScheme()
  augroup END

endif

