vim9script

if exists("g:loaded_fzf_plugin") || exists('g:loaded_fzf')
  finish
endif

g:loaded_fzf_plugin = 1

logger#Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

# Use vim window popup
# g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1.0, 'border': 'top', 'highlight': 'Todo' } }
g:fzf_layout = { 'down': '~40%' } # use terminal window
# g:fzf_layout = { 'window': 'enew' } # use vim window

$FZF_DEFAULT_OPTS = ' --layout=reverse --preview-window="noborder:wrap" --info=inline --multi --bind="f2:toggle-preview,ctrl-w:toggle-preview-wrap" --bind="ctrl-d:half-page-down,ctrl-u:half-page-up" --bind="ctrl-f:page-down,ctrl-b:page-up,ctrl-l:clear-query"'

# Ctrl-q allows to select multiple elements an open them in quick list
g:fzf_action = {
  'ctrl-q': function('_#qfloc#build_quickfix_list'),
  'ctrl-t': 'tab split',
  'ctrl-s': 'split',
  'ctrl-v': 'vsplit' }

# Prefix all fzf.vim exported commands with ''
g:fzf_command_prefix = ''

# [Buffers] Jump to the existing window if possible
g:fzf_buffers_jump = 1

# Preview window options
g:fzf_preview_window = ['right:50%:wrap']

# Enable per-command history.
# CTRL-N and CTRL-P will be automatically bound to next-history and
# previous-history instead of down and up. If you don't like the change,
# explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
g:fzf_history_dir = '~/.cache/fzf-history'

# 'pbogut/fzf-mru.vim' settings
# MRU cache location is: 'echo fzf_mru#mrufiles#cachefile()'
# Store only files relative to cwd, we don't care about files outside the workspace
g:fzf_mru_relative = 1

# Regex pattern to exclude files from MRU list (if you need it)
# g:fzf_mru_exclude = ''

# Keep up to 20 items in MRU
g:fzf_mru_max = 20

g:rg_command = ' rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "*.{tf,yml,yaml,vim,viml,tsx,ts,js,jsx,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,graphql,gql,sql}" -g "!{spell,pack,.config,.git,node_modules,vendor,yarn.lock,*.sty,*.bst,build,dist}/*" '

# Customize fzf colors to match your color scheme
# - fzf#wrap translates this to a set of `--color` options
g:fzf_colors = {
  'fg':      ['fg', 'Normal'],
  'bg':      ['bg', 'Normal'],
  'hl':      ['fg', 'Comment'],
  'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  'hl+':     ['fg', 'Statement'],
  'info':    ['fg', 'PreProc'],
  'border':  ['fg', 'Ignore'],
  'prompt':  ['fg', 'Conditional'],
  'pointer': ['fg', 'Exception'],
  'marker':  ['fg', 'Keyword'],
  'spinner': ['fg', 'Label'],
  'header':  ['fg', 'Comment']
}
