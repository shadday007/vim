vim9script

if exists('g:loaded_netrw_plugin')
  finish
endif

g:loaded_netrw_plugin = 1

logger#Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

g:netrw_use_noswf = 0

g:netrw_liststyle = 0

g:netrw_altv = 1

g:netrw_preview = 1
g:netrw_winsize = 20

# open url under cursor using 'gx'
g:netrw_browsex_viewer = "xdg-open"

# The home directory for where bookmarks and history are saved
g:netrw_home = "~/.config" .. "/vim"

# trying to make netrw more nice
# Hide banner. To show again press I
g:netrw_banner = 0

#Sincronizar el directorio actual y el directorio que está mostrando Netrw. Esto ayuda con el error cuando se intenta mover archivos.
g:netrw_keepdir = 0

# Hide dotfiles
g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

# copy recursive
g:netrw_localcopydircmd = 'cp -r'

highlight! link netrwMarkFile Search

