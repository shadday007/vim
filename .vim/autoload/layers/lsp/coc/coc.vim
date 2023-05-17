vim9script

import autoload "corefunctions.vim" as CF
import autoload "layers.vim"
import autoload "logger.vim"

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
