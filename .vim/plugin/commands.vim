vim9script

if exists('g:loaded_commands_plugin')
  finish
endif

g:loaded_commands_plugin = 1

logger#Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

import autoload "statusline.vim"

var shell_job: number

def CallStop(timer: number): void
  statusline.JobStop()
enddef

def JobExit(job: job, status: number)
  var ch = job_getchannel(job)
  while ch_status(ch) ==# 'open' | sleep 1ms | endwhile
  while ch_status(ch) ==# 'buffered' | sleep 1ms | endwhile
  timer_start(10, 'CallStop')
enddef

def GotOutput(channel: channel, msg: string)
  statusline.JobAddProgress()
  redrawstatus
enddef

def PackComplete(ArgLead: string, CmdLine: string, CursorPos: number): list<string>
  var list: list<string> = [
    'group',
    'rmgroup',
    'install',
    'uninstall',
    'list',
    'update',
    'clean',
    'gendocs',
    'process',
  ]
  return list->filter((_, l) => l =~ ArgLead)
enddef

# Run the pack-manager bash script
command! -nargs=* -bang -complete=customlist,PackComplete  PackManager {
  var cmd = $HOME .. '/.vim/pack/pack-manager ' .. '<args>'
  var opts = {}
  opts.term_finish = 'open'
  opts.hidden = 1
  opts.out_msg = 0
  opts.vertical = 1
  opts.callback = 'GotOutput'
  opts.exit_cb = 'JobExit'
  opts.term_name = 'pack_terminal'
  shell_job = term_start(cmd, opts)
}

# Shortcuts for access files
command! Vimrc edit ~/.vim/vimrc
command! Vimrcoptions edit ~/.vim/plugin/options.vim
command! Vimrcmappings edit ~/.vim/after/plugin/mappings.vim
command! Vimrcautocommands edit ~/.vim/plugin/autocommands.vim
command! Vimrccommands edit ~/.vim/plugin/commands.vim
command! Vimrcplugins edit ~/.vim/plugin/plugins.vim

command! Bashrc edit ~/.bashrc
command! Gitconfig edit ~/.gitconfig

command! MyDiary edit ~/Dropbox/notes/notes.md
command! MyTODO edit ~/Dropbox/notes/todo.md

command Todo noautocmd Grep '\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\):' ** | cwindow
command Note noautocmd Grep '\(NOTE\|INFO\|IDEA\):' ** | cwindow
command Debug noautocmd Grep '\(HELP\|DEBUG\):' ** | cwindow
command Error noautocmd Grep '\(ERROR\|FATAL\):' ** | cwindow
