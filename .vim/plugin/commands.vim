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

command FindTodos noautocmd vimgrep /\v\C<(TODO|FIXME|CHANGED|XXX|BUG|HACK)>/j ** | cw
command FindNotes noautocmd vimgrep /\C\W\zs\(NOTE\|INFO\|IDEA\)/j ** | cw
command FindDebugs noautocmd vimgrep /\C\W\zs\(HELP\|DEBUG\)/j ** | cw
command FindErrors noautocmd vimgrep /\C\W\zs\(ERROR\|FATAL\)/j ** | cw
