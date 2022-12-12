vim9script

# Run the pack-manager bash script
command! -nargs=* -complete=command  PackManager  !~/.vim/pack/pack-manager <args>
