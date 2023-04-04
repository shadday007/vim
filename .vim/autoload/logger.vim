vim9script

# # Here's a general guideline on when to use each log level:

# TRACE - Use this level to log very detailed information, such as
# variable values, function calls, and program flow. This level is typically used for
# debugging purposes and is not useful in production environments.

# DEBUG - Use this level to log detailed information about the program's
# state and behavior. This level is useful for debugging purposes or when
# troubleshooting issues in a development environment.

# INFO - Use this level to log general information about the program's
# operation, such as when a function is called or a task is completed. This level can
# beuseful for monitoring the program's behavior in production environments.

# WARNING - Use this level to log warning messages, such as when a
# function receives invalid input or when a file cannot be found. These messages
# indicate potential issues that may affect the program's behavior.

# ERROR - Use this level to log error messages, such as when a function
# encounters an unexpected error or when a critical file cannot be accessed. These
# messages indicate serious issues that may cause the program to fail or behave
# incorrectly.

var levels = {
  1: 'TRACE',
  2: 'DEBUG',
  3: 'INFO',
  4: 'WARNING',
  5: 'ERROR',
  99: 'SYSTEM'
}

# Global options
# 1: TRACE, 2: DEBUG, 3: INFO, 4: WARNING, 5: ERROR
var log_level = get(g:, 'logger_level', 1)
var log_verbose = get(g:, 'logger_verbose', v:false)
var log_file = get(g:, 'logger_file', $HOME .. '/.vim/log/log.txt')


# Function to log trace messages
export def Trace(message: string): number
    return Log(message, 1)
enddef

# Function to log debug messages
export def Debug(message: string): number
    return Log(message, 2)
enddef

# Function to log info messages
export def Info(message: string): number
    return Log(message, 3)
enddef

# Function to log warning messages
export def Warning(message: string): number
    return Log(message, 4)
enddef

# Function to log error messages
export def Error(message: string): number
    return Log(message, 5)
enddef

# Function to log trace messages
export def System(message: string): number
    return Log(message, 99)
enddef

# Function to log messages
def Log(message: string, level: number = 2): number
    # Check if message level is above global log level
    if level < log_level
        return 0
    endif

    # Build log message
    var log_message = '['
        .. printf('%-9s', levels[level]  .. '] ')
        .. strftime('%Y-%m-%d %H:%M:%S')
        .. ' - ' .. message

    # Print log message if verbose mode is on
    if log_verbose
        echo log_message
    endif

    # Write log message to file
    writefile([log_message], log_file, 'a')
    return 1
enddef

export def ShowLog()
    Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))
    # Check if log file exists
    if !filereadable(log_file)
        echo 'Log file does not exist'
        return
    endif

    # Open log file in read-only mode
    var log_buf = bufnr(log_file)
    if log_buf == -1
        Trace('vertical botright split ' .. log_file)
        execute 'vertical botright split ' .. log_file
        log_buf = bufnr('')
        execute 'setlocal buftype=nofile filetype=log bufhidden=hide noswapfile nomodifiable'
    else
      # Switch to log buffer and display it
      Trace('vertical botright sbuffer ' .. log_buf)
      execute 'vertical botright sbuffer ' .. log_buf
    endif

    setlocal wrap
    setlocal nowrapscan
    setlocal scrolloff=999
    setlocal cursorline
    setlocal autoread

    syn match logNumber       '\<-\?\d\+\>'
    syn match LogBracket /[[\]]/
    syn match LogDate /\d\{4}-\d\{2}-\d\{2}/
    syn match LogHour /\d\{2}:\d\{2}:\d\{2}/
    syn match LogTrace /TRACE/
    syn match LogDebug /DEBUG/
    syn match LogInfo /INFO/
    syn match LogWarning /WARNING/
    syn match LogError /ERROR/
    syn match LogSystem /SYSTEM/
    syn match logFilePath   '[^a-zA-Z0-9"']\@<=\/\w[^\n|,; ()'"\]{}]\+'
    hi def link LogNumber Number
    hi def link LogBracket Comment
    hi def link LogDate Identifier
    hi def link LogHour Function
    hi def link LogTrace Comment
    hi def link LogDebug Debug
    hi def link LogInfo Repeat
    hi def link LogWarning WarningMsg
    hi def link LogError Error
    hi def link LogSystem Constant
    hi def link LogFilePath Conditional

    normal! G
    nnoremap <buffer><silent> q :bd<CR>
enddef
