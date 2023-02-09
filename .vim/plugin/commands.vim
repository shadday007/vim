vim9script

if exists('g:loaded_commands_plugin')
  finish
endif

g:loaded_commands_plugin = 1

# Run the pack-manager bash script
command! -nargs=* -complete=command  PackManager  !~/.vim/pack/pack-manager <args>

# Shortcuts for access files
command! Vimrc edit ~/.vim/vimrc
command! Vimrcplugins edit ~/.vim/plugin/plugins.vim
command! Vimrcoptions edit ~/.vim/plugin/options.vim
command! Vimrcmappings edit ~/.vim/after/plugin/mappings.vim
command! Vimrcautocommands edit ~/.vim/plugin/autocommands.vim

command! Bashrc edit ~/.bashrc
command! Gitconfig edit ~/.gitconfig

command! Diary edit ~/Dropbox/code-notes/notes.md
command! TODO edit ~/Dropbox/code-notes/todo.md


