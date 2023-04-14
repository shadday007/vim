vim9script

import autoload "corefunctions.vim" as CF
import autoload "layers.vim"
import autoload "logger.vim"

# NOTE: 2023-03-22(shadday): remember use call <SID>Func()

# INFO: 2023-03-22(shadday): plugins dict structure
# {
#   'plugin' : {
#
#   }

# lazyload.Lazy({
#   'plugin': 'vim-grepper',
#   'commands': {
#     'Grepper': '-nargs=? -bar -bang',
#   },
#   'beforeload': [
#     'grepper#GrepperInit()',
#   ],
#   'nnoremap': {
#     '<leader>fga': ':Grepper -tool ag<cr>',
#     '<leader>fgr': ':Grepper -tool rg<cr>',
#     '<leader>fgg': ':Grepper -tool git<cr>',
#     '<leader>fgs': ':Grepper -tool ag -side<cr>',
#     '<leader>f* ': ':Grepper -tool ag -cword -noprompt<cr>',
#     '<leader>fg':  ':Grepper<cr>',
#     'gs': '<plug>(GrepperOperator)'
#   },
#   'xnoremap': {
#     'gs': '<plug>(GrepperOperator)'
#   },
#   'afterload': [
#     'grepper#GrepperUserCommands()',
#   ]
# })

def Plugins(): list<any> # A.K.A. Packages
  var plugins: list<any> = []

  plugins = [
    {
      'repository': 'neoclide/coc.nvim',
      'branch': 'release',
      'load': 'now',
      'priority': 0,
      'group': 'lsp',
      'opt': 'opt',
      # 'do': 'cd ~/.vim/pack/lsp/opt/coc.nvim ; yarn install --frozen-lockfile',
      'beforeload': [
      'layers#lsp#coc#coc#CocConfig()',
      ],
      'afterload': [
      'layers#lsp#coc#coc#CocFunctions()',
      'layers#lsp#coc#coc#CocAfter()',
      ]
    },
  ]
  return plugins
enddef

export def SetupLayer()
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

  var layers_packages: list<any> = Plugins()
  layers.EnableLayers(layers_packages)
enddef

export def CocConfig()
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

  const file_config: string = expand("~/.vim/autoload/layers/lsp/coc/config.vim")
  if filereadable(file_config)
    execute 'source ' .. file_config
  endif
enddef

export def CocFunctions()
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

  const file_functions: string = expand("~/.vim/autoload/layers/lsp/coc/functions.vim")
  if filereadable(file_functions)
    execute 'source ' .. file_functions
  endif
enddef

export def CocAfter()
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

  const file_mapping: string = expand("~/.vim/autoload/layers/lsp/coc/mapping.vim")
  if filereadable(file_mapping)
    execute 'source ' .. file_mapping
  endif
 enddef
