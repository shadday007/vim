vim9script

if exists("g:loaded_defer_plugins_plugin")
  finish
endif

g:loaded_defer_plugins_plugin = 1

logger#Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

import autoload "defer.vim"

import autoload "lazyload.vim"

# All plugins must be installed in opt
# ~/.vim/plugins.pack

# --------------------------------------------------
# Defer Mechanism
# --------------------------------------------------
defer.Packadd('vim-unimpaired')

defer.Packadd('vim-polyglot')

defer.Packadd('unicode.vim')

defer.Packadd('vim-cheat40')

# --------------------------------------------------
# Lazy Load  Mechanism
# --------------------------------------------------
lazyload.Lazy({
  'plugin': 'goyo.vim',
  'commands': {
    'Goyo': '-nargs=? -bar -bang'
  }
})

lazyload.Lazy({
  'plugin': 'undotree',
  'nnoremap': {
    '<silent> <Leader>t': ':UndotreeToggle<CR>'
  },
  'beforeload': [
  'g:undotree_HighlightChangedText = 0',
  'g:undotree_SetFocusWhenToggle = 1',
  'g:undotree_WindowLayout = 2',
  'g:undotree_DiffCommand = "diff -u"'
  ]
})

lazyload.Lazy({
  'plugin': 'vim-mundo',
  'nnoremap': {
    '<silent> <Leader>u': ':MundoToggle<CR>'
  },
  'beforeload': [
    'g:mundo_preview_bottom = 1'
  ]
})

lazyload.Lazy({
  'plugin': 'gv.vim',
  'commands': {
    'GV': '-nargs=? -bar -bang'
  }
})

lazyload.Lazy({
  'plugin': 'vim-flog',
  'commands': {
    'Flog': '-nargs=? -bar -bang',
    'Flogsplit': '-nargs=? -bar -bang'
  }
})

lazyload.Lazy({
  'plugin': 'vim-grepper',
  'commands': {
    'Grepper': '-nargs=? -bar -bang',
  },
  'beforeload': [
    'grepper#GrepperInit()',
  ],
  'nnoremap': {
    '<leader>fga': ':Grepper -tool ag<cr>',
    '<leader>fgr': ':Grepper -tool rg<cr>',
    '<leader>fgg': ':Grepper -tool git<cr>',
    '<leader>fgs': ':Grepper -tool ag -side<cr>',
    '<leader>f* ': ':Grepper -tool ag -cword -noprompt<cr>',
    '<leader>fg':  ':Grepper<cr>',
    'gs': '<plug>(GrepperOperator)'
  },
  'xnoremap': {
    'gs': '<plug>(GrepperOperator)'
  },
  'afterload': [
    'grepper#GrepperUserCommands()',
  ]
})

lazyload.Lazy({
  'plugin': 'vim-plugin-ansiesc',
  'commands': {
    'AnsiEsc': '-nargs=? -bar -bang'
  }
})
