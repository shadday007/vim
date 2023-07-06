vim9script

import autoload "corefunctions.vim" as CF
import autoload "layers.vim"
import autoload "logger.vim"

def Plugins(): list<any> # A.K.A. Packages

  var plugins: list<any> = [
    {
      'repository': 'Exafunction/codeium.vim',
      'load': 'now',
      'priority': 0,
      'group': 'ai',
      'opt': 'opt',
      'beforeload': [
      'layers#ai#codeium#codeium#CodeiumConfig()',
      ],
    },
  ]
  return plugins
enddef

export def SetupLayer()
  logger.Trace('[Codeium#SetupLayer]-> Begin')

  var layers_packages: list<any> = Plugins()
  layers.EnableLayers(layers_packages)
enddef

export def CodeiumConfig()
  logger.Trace('[CodeiumConfig]-> Begin')

  imap <script><silent><nowait><expr> <C-g> codeium#Accept()
  imap <C-;>   <Cmd>call codeium#CycleCompletions(1)<CR>
  imap <C-,>   <Cmd>call codeium#CycleCompletions(-1)<CR>
  imap <C-x>   <Cmd>call codeium#Clear()<CR>
enddef
