vim9script
if !exists('g:colors_name') || g:colors_name != 'base16-horizon-terminal-dark'
  execute 'silent !/bin/bash /home/shadday/.config/bash/scripts/base16_shell_colors.sh'
  colorscheme base16-horizon-terminal-dark
  set background=dark
endif
