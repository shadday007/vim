vim9script

if exists('g:loaded_autocommands_plugin')
  finish
endif

g:loaded_autocommands_plugin = 1

def Trim_white_space(): void
  execute :%s/\s\+$//e
enddef

def AutoCommands(): void

  # Create directories before write
  autocmd BufWritePre * if expand("<afile>") !~# '^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p " .. shellescape(expand('%:h'), 1) | redraw! | endif

  # Auto-resize splits when Vim gets resized.
  autocmd VimResized * wincmd =

  # Update a buffer's contents on focus if it changed outside of Vim.
  autocmd FocusGained,BufEnter * :checktime

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
  autocmd BufWinLeave * clearmatches()

  autocmd BufWritePre * :%s/\s\+$//e
  autocmd FileWritePre   * :%s/\s\+$//e
  autocmd FileAppendPre  * :%s/\s\+$//e
  autocmd FilterWritePre * :%s/\s\+$//e

  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END

enddef

AutoCommands()
