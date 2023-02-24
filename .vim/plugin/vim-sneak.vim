vim9script

if exists("g:loaded_sneak_plugin")
  finish
endif

g:loaded_sneak_plugin = 1

g:sneak#label = 1
map s <Plug>Sneak_s
map S <Plug>Sneak_S

