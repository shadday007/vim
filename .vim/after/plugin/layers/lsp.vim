vim9script

if exists("g:loaded_lsp_plugin")
  finish
endif

g:loaded_lsp_plugin = 1

import autoload "logger.vim"

var topic: string = expand('<sfile>:t:r')

logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

if !get(g:, topic .. "_enable", false)
  logger.Trace('this topic layer is not enable: ' .. topic)
  finish
endif

var time = reltime()


import autoload "corefunctions.vim" as CF

var layer = get(g:, topic .. '_layer', 'lsp')

var import_cmd: string = 'import autoload "'
  .. 'layers/' .. topic .. '/'
  .. layer .. '/' .. layer .. '.vim"'
  .. ' as ' .. topic

execute import_cmd

logger.Debug("Call " .. topic .. '.SetupLayer')
call(topic .. '.SetupLayer', [])

logger.Info('Layer mechanism version simple spend:' .. matchstr(reltimestr(reltime(time)), '.*\..\{,6}') .. ' seconds to run')
