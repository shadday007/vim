vim9script

if exists("g:loaded_gutentags_plus_plugin")
  finish
endif

g:loaded_gutentags_plus_plugin = 1

logger#Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

# configuration for gutentags_plus plugin

g:gutentags_ctags_exclude_wildignore = 1

g:gutentags_ctags_exclude = [
  'node_modules', '_build', 'build', 'CMakeFiles', '.mypy_cache', 'venv',
  'proc', '.steam', 'opam', '.sourcegraph', 'opera', 'snapd', '.steampath',
  '*.md', '*.tex', '*.css', '*.html', '*.json', '*.xml', '*.xmls', '*.ui']

# config project root markers.
g:gutentags_project_root = ['Makefile', '.root', 'vimrc']

# enable gtags module
# g:gutentags_modules = ['ctags']
g:gutentags_modules = ['ctags', 'gtags_cscope']

# Defines some advanced commands like |GutentagsToggleEnabled| and |GutentagsUnlock|.
g:gutentags_define_advanced_commands = 1

# generate datebases in my cache directory, prevent gtags files polluting my project
g:gutentags_cache_dir = expand('~/.cache/tags')

set tags=./tags;tags;expand('~/.cache/tags')

# change focus to quickfix window after search (optional).
# g:gutentags_plus_switch = 1

# disable the default keymaps by:
# g:gutentags_plus_nomap = 1

command! -nargs=0 GutentagsClearCache call system('rm ' .. g:gutentags_cache_dir .. '/*')
