vim9script

export def ErrorMsg(msg: string): void
  echohl ErrorMsg
  echo '[vim]-> ' .. msg
  echohl None
enddef

export def WarningMsg(msg: string): void
  echohl WarningMsg
  echo '[vim]-> ' .. msg
  echohl None
enddef

export def InfoMsg(msg: string): void
  echohl ModeMsg
  echo '[vim]-> ' .. msg
  echohl None
enddef

