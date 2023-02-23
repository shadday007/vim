vim9script

if exists("g:loaded_quick_scope_plugin")
  finish
endif

g:loaded_quick_scope_plugin = 1

# Trigger a highlight in the appropriate direction when pressing these keys:
g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

# Turn off this plugin when the length of line is longer than
g:qs_max_chars = 200

#  list of buffer types disables the plugin
g:qs_buftype_blacklist = ['terminal', 'nofile']

#  list of file types disables the plugin
g:qs_filetype_blacklist = ['dashboard', 'startify']

if has('timers')
    g:qs_delay = 0
endif

g:qs_lazy_highlight = 1
