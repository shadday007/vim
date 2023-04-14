vim9script

if exists("g:loaded_logger_plugin")
  finish
endif

g:loaded_logger_plugin = 1

# import autoload "logger.vim"

# Global options
g:logger_level = 2  # 1: TRACE, 2: DEBUG, 3: INFO, 4: WARNING, 5: ERROR
g:logger_verbose = v:false
g:logger_file = expand( $HOME .. '/.vim/log/vim.log' )

if !filereadable(g:logger_file)
  var dir_name =  fnamemodify(g:logger_file, ':h')
  mkdir(dir_name, 'p')
endif

command! ShowLog call logger#ShowLog()
command! ClearLog delete(g:logger_file)

logger#System('### Initiate [VIM] log runtime ###')
