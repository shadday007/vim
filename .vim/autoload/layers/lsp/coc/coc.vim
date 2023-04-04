vim9script

import autoload "corefunctions.vim" as CF
import autoload "layers.vim"

# NOTE: 2023-03-22(shadday): remember use call <SID>Func()

# INFO: 2023-03-22(shadday): plugins dict structure
# {
#   'plugin' : {
#
#   }

def Plugins(): list<any> # A.K.A. Packages
  var plugins: list<any> = []

  plugins = [
    {
      'repository': 'neoclide/coc.nvim',
      'load': 'now',
      'priority': 0,
      'group': 'lsp',
      'opt': 'opt',
    },
  ]
  return plugins
enddef

export def SetupLayer()
  var layers_packages: list<any> = Plugins()

  layers.EnableLayers(layers_packages)
enddef
