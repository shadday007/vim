vim9script

import autoload "lazyload.vim"

# Generic mechanism for scheduling a unit of deferable work.
export def Defer(evalable: string)
  if has('autocmd') && has('vim_starting')
    # Note that these commands are not defined in a group, so that we can call
    # this function multiple times. We rely on autocmds#idleboot to ensure that
    # this event is only fired once.
    execute 'autocmd User Defer ' .. evalable
  else
    execute evalable
  endif
enddef

# Convenience function specifically for defering a `:packadd` operation.
export def Packadd(pack: string, plugin: string)
  execute "Defer('lazyload.Packadd(\"' .. pack .. '\", \"' .. plugin .. '\")')"
enddef
