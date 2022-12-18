vim9script

def g:CheckColorScheme()

  if !has('termguicolors')
    g:base16colorspace = 256
  endif

  if exists("g:base16_shell_path")
    unlet g:base16_shell_path
  endif

  colorscheme base16

  g:current_color_scheme = g:colors_name
  g:colors_name = "base16"

enddef
