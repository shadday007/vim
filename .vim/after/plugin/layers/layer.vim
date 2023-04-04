vim9script

if exists("g:loaded_layers_plugin")
  finish
endif

g:loaded_layers_plugin = 1

import autoload "corefunctions.vim" as CF
import autoload "logger.vim"

var time = reltime()
logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

g:topics = CF.GetTopics()
g:all_plugins = CF.GetAllPlugins()
g:installed_plugins = []
extend(g:installed_plugins, g:all_plugins['start'])
extend(g:installed_plugins, g:all_plugins['opt'])

logger.Info("large version spend " .. matchstr(reltimestr(reltime(time)), '.*\..\{,6}') .. ' seconds to generate dictionaries and lists..!')

logger.Debug(printf("g:topics = %s", g:topics))
logger.Debug(printf("g:all_plugins = %s", g:all_plugins))
logger.Debug(printf("g:installed_plugins = %s", g:installed_plugins))

var layer: string = ''
var import_cmd: string = ''

for topic in keys(g:enable_layers)
  layer = g:enable_layers[topic]
  logger.Debug('Check layer: ' .. layer)

  if index(keys(g:topics), topic) >= 0  # If topic is in the dict.
    if index(g:topics[topic], layer) >= 0  # If layer is in the list.

      import_cmd = 'import autoload "'
        .. 'layers/' .. topic .. '/'
        .. layer .. '/' .. layer .. '.vim"'
        .. ' as ' .. topic

      execute import_cmd

      logger.Debug('Call : ' .. topic .. '.SetupLayer')
      call(topic .. '.SetupLayer', [])
    else
      logger.Warning("layer: " .. layer .. " isn't implemented yet!.")
      CF.ErrorMsg("layer: " .. layer .. " isn't implemented yet!.")
    endif
  else
    logger.Warning("topic " .. topic .. " isn't implemented yet!.")
    CF.ErrorMsg("topic " .. topic .. " isn't implemented yet!.")
  endif
endfor

logger.Info("large version spend " .. matchstr(reltimestr(reltime(time)), '.*\..\{,6}') .. ' seconds to run')
