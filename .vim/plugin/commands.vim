vim9script

if exists('g:loaded_commands_plugin')
  finish
endif

g:loaded_commands_plugin = 1

# Run the pack-manager bash script
command! -nargs=* -complete=command  PackManager  !~/.vim/pack/pack-manager <args>

# Shortcuts for access files
command! Vimrc edit ~/.vim/vimrc
command! Vimrcoptions edit ~/.vim/plugin/options.vim
command! Vimrcmappings edit ~/.vim/after/plugin/mappings.vim
command! Vimrcautocommands edit ~/.vim/plugin/autocommands.vim
command! Vimrccommands edit ~/.vim/plugin/commands.vim
command! Vimrcplugins edit ~/.vim/plugin/plugins.vim

command! Bashrc edit ~/.bashrc
command! Gitconfig edit ~/.gitconfig

command! MyDiary edit ~/Dropbox/notes/notes.md
command! MyTODO edit ~/Dropbox/notes/todo.md

command Todo noautocmd Grep '\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\):' ** | cwindow
command Note noautocmd Grep '\(NOTE\|INFO\|IDEA\):' ** | cwindow
command Debug noautocmd Grep '\(HELP\|DEBUG\):' ** | cwindow
command Error noautocmd Grep '\(ERROR\|FATAL\):' ** | cwindow
