vim9script

if exists("g:loaded_statusline_plugin")
  finish
endif

g:loaded_statusline_plugin = 1

logger#Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

import autoload "statusline.vim"
if has('statusline')
  set statusline=%!Statusline()
endif

if has('autocmd')
  augroup git_statusline
    au!
    autocmd VimEnter            * statusline.GitInfo()
    autocmd BufEnter            * statusline.GitInfo()
    autocmd CursorHold          * statusline.GitInfo()
    autocmd BufWritePost        * statusline.GitInfo()
    autocmd ShellCmdPost        * statusline.GitInfo()
    autocmd DirChanged          * statusline.GitInfo()
    autocmd User GitUpdate        statusline.GitInfo()
  augroup END

  augroup StatusLine
    autocmd!
    autocmd ColorScheme * statusline.Update_highlight()

    if exists('##TextChangedI')
      autocmd BufWinEnter,BufWritePost,FileWritePost,TextChanged,TextChangedI,WinEnter * statusline.Check_modified()
    else
      autocmd BufWinEnter,BufWritePost,FileWritePost,WinEnter * statusline.Check_modified()
    endif

    autocmd BufEnter,FocusGained,VimEnter,WinEnter * statusline.Focus_window() | setlocal cursorline
    autocmd FocusLost,WinLeave * statusline.Blur_window() | setlocal nocursorline

    autocmd WinResized,TextChanged,TextChangedI * unlet! b:sl_warnings
    autocmd VimResized    *      redrawstatus

    autocmd CursorHold,CursorHoldI * statusline.CapStatus() | statusline.NumStatus()
  augroup END
endif
