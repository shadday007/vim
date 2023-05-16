vim9script

if exists("g:loaded_layers_plugin")
  finish
endif

g:loaded_layers_plugin = 1

def TopicAndLayerExist(tpc: string, lyr: string): bool
  if index(keys(g:topics), tpc) >= 0  # If topic is in the dict.
    if index(g:topics[tpc], lyr) >= 0  # If layer is in the list.
      return true
    else
      logger.Warning("layer: " .. lyr .. " isn't implemented yet!.")
      CF.ErrorMsg("layer: " .. lyr .. " isn't implemented yet!.")
    endif
  else
    logger.Warning("topic " .. tpc .. " isn't implemented yet!.")
    CF.ErrorMsg("topic " .. tpc .. " isn't implemented yet!.")
  endif
  return false
enddef

var time = reltime()
var is_simple_method: bool =  g:layer_method == 'simple'

import autoload "logger.vim"

logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

if !is_simple_method
  import autoload "corefunctions.vim" as CF

  g:topics = CF.GetTopics()
  g:all_plugins = CF.GetAllPlugins()
  g:installed_plugins = []
  extend(g:installed_plugins, g:all_plugins['start'])
  extend(g:installed_plugins, g:all_plugins['opt'])

  logger.Info("large version spend " .. matchstr(reltimestr(reltime(time)), '.*\..\{,6}') .. ' seconds to generate dictionaries and lists..!')
  logger.Debug(printf("g:topics = %s", g:topics))
  logger.Debug(printf("g:all_plugins = %s", g:all_plugins))
  logger.Debug(printf("g:installed_plugins = %s", g:installed_plugins))
endif

var layer: string = ''
var import_cmd: string = ''

for topic in keys(g:enable_layers)
  layer = g:enable_layers[topic]
  logger.Debug('Check layer: ' .. layer)

  if is_simple_method || TopicAndLayerExist(topic, layer)

      import_cmd = 'import autoload "'
        .. 'layers/' .. topic .. '/'
        .. layer .. '/' .. layer .. '.vim"'
        .. ' as ' .. topic

      execute import_cmd

      logger.Debug('Call : ' .. topic .. '.SetupLayer')
      call(topic .. '.SetupLayer', [])
  endif
endfor

logger.Info('Layer mechanism spend:' .. matchstr(reltimestr(reltime(time)), '.*\..\{,6}') .. ' seconds to run')
