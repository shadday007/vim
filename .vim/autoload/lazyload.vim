vim9script

var plugins={}

export def Lazy(config: dict<any>)
  var id = config.pack .. '::' .. config.plugin
  plugins[id] = config
  var load = 'call <SID>load("' .. id .. '")'
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
  if has_key(config, 'nnoremap')
    for mapping in items(config.nnoremap)
      execute 'nnoremap ' ..
        mapping[0] .. ' ' ..
        ':' .. l:load .. '<CR>' ..
        mapping[1]
    endfor
  endif
enddef

export def Load(id: string)
  var config = plugins[id]
  var split = split(id, '::')
  var pack = split[0]
  var plugin = split[1]
  if has_key(config, 'beforeload')
    for item in config.beforeload
      execute item
    endfor
  endif
  Packadd(pack, plugin)
  if has_key(config, 'nnoremap')
    for mapping in items(config.nnoremap)
      execute 'nnoremap ' .. mapping[0] .. ' ' .. mapping[1]
    endfor
  endif
  if has_key(config, 'afterload')
    for item in config.afterload
      execute item
    endfor
  endif
enddef

export def Packadd(pack: string, plugin: string)
  if has('packages')
    execute 'packadd ' .. pack
  end
enddef
