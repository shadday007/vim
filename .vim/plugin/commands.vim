vim9script

if exists('g:loaded_commands_plugin')
  finish
endif

g:loaded_commands_plugin = 1

# Run the pack-manager bash script
command! -nargs=* -complete=command  PackManager  !~/.vim/pack/pack-manager <args>
