vim9script

var plugins = {}

import autoload "logger.vim"

export def Lazy(config: dict<any>)
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))
  var id = config.plugin
  plugins[id] = config
  var load = 'call <SID>Load("' .. id .. '")'
  if has_key(config, 'commands')
    for command in items(config.commands)
      var deletions = map(keys(config.commands), '"delcommand " .. v:val')
      execute 'command! ' ..
            command[1] .. ' ' ..
            command[0] .. ' ' ..
            ':' .. join(deletions, ' <bar> ') .. ' <bar> ' ..
            load .. ' <bar> ' ..
            command[0] ..
            ' <args>'
    endfor
  endif
  BeforeMaps(config, 'nnoremap', load)
  BeforeMaps(config, 'vnoremap', load)
  BeforeMaps(config, 'xnoremap', load)
  BeforeMaps(config, 'snoremap', load)
  BeforeMaps(config, 'onoremap', load)
  BeforeMaps(config, 'inoremap', load)
  BeforeMaps(config, 'lnoremap', load)
  BeforeMaps(config, 'cnoremap', load)
  BeforeMaps(config, 'tnoremap', load)
enddef

def BeforeMaps(config: dict<any>, map: string, load: string): void
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))
  if has_key(config, map)
    for mapping in items(config[map])
      execute map .. ' ' ..
        mapping[0] .. ' ' ..
        ':' .. load .. '<CR>' ..
        mapping[1]
    endfor
  endif
enddef

def AfterMaps(config: dict<any>, map: string): void
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))
  if has_key(config, map)
    for mapping in items(config[map])
      execute map .. ' ' .. mapping[0] .. ' ' .. mapping[1]
    endfor
  endif
enddef

def Load(id: string)
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))
  var config = plugins[id]
  var plugin = id
  if has_key(config, 'beforeload')
    for item in config.beforeload
      execute item
    endfor
  endif
  Packadd(plugin)
  AfterMaps(config, 'nnoremap')
  AfterMaps(config, 'vnoremap')
  AfterMaps(config, 'xnoremap')
  AfterMaps(config, 'snoremap')
  AfterMaps(config, 'onoremap')
  AfterMaps(config, 'inoremap')
  AfterMaps(config, 'lnoremap')
  AfterMaps(config, 'cnoremap')
  AfterMaps(config, 'tnoremap')
  if has_key(config, 'afterload')
    for item in config.afterload
      execute item
    endfor
  endif
enddef

export def Packadd(plugin: string)
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))
  if has('packages')
    execute 'packadd ' .. plugin
    logger.Info('Plugin: ' .. plugin .. ' Loaded!.')
  endif
enddef
