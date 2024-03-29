vim9script

if exists('g:loaded_autocommands_plugin')
  finish
endif

g:loaded_autocommands_plugin = 1

logger#Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

def Trim_white_space(): void
  execute :%s/\s\+$//e
enddef

def Idleboot()
  # Make sure we automatically call Idleboot() only once.
  augroup idleboot
    autocmd!
  augroup END

  # Make sure we run deferred tasks exactly once.
  doautocmd User Defer
  autocmd! User Defer
enddef

def AutoCommands(): void

  # Create directories before write
  autocmd BufWritePre * if expand("<afile>") !~# '^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p " .. shellescape(expand('%:h'), 1) | redraw! | endif

  # Auto-resize splits when Vim gets resized.
  autocmd VimResized * wincmd =

  # Update a buffer's contents on focus if it changed outside of Vim.
  autocmd FocusGained,BufEnter * silent! checktime

  # Remember last position in file:
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

  if exists("+omnifunc")
    autocmd Filetype * if &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
  endif

  # Extras White spaces
  highlight default ExtraWhitespace ctermbg=red guibg=red
  autocmd ColorScheme <buffer> highlight default ExtraWhitespace ctermbg=red guibg=red
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/

  autocmd BufWritePre * :%s/\s\+$//e
  autocmd FileWritePre   * :%s/\s\+$//e
  autocmd FileAppendPre  * :%s/\s\+$//e
  autocmd FilterWritePre * :%s/\s\+$//e

  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END

  augroup filemarks
    autocmd!
    autocmd BufLeave *.vim  normal! mV
    autocmd BufLeave *.css  normal! mC
    autocmd BufLeave *.html normal! mH
    autocmd BufLeave *.js   normal! mJ
    autocmd BufLeave *.php  normal! mP
  augroup END

  augroup mysyntax
    autocmd!
    autocmd Syntax * matchadd('Todo',  '\v\W\zs<(TODO|FIXME|CHANGED|XXX|BUG|HACK)>')
    autocmd Syntax * matchadd('ModeMsg', '\v\W\zs<(NOTE|INFO|IDEA)>')
    autocmd Syntax * matchadd('Search', '\v\W\zs<(HELP|DEBUG)>')
    autocmd Syntax * matchadd('ExtraWhiteSpace', '\v\W\zs<(ERROR|FATAL)>')
  augroup END

  augroup sourcevimfiles
    autocmd!
    autocmd BufWritePost,FileWritePost *.vim,~/.vimrc,~/.vim/vimrc source <afile>
  augroup END

  # Wait until idle to run additional "boot" commands.
  augroup idleboot
    autocmd!
    if has('vim_starting')
      autocmd CursorHold,CursorHoldI * ++once Idleboot()
    endif
  augroup END

  autocmd User Defer echom "Executing User Deferring commands"
enddef

AutoCommands()
