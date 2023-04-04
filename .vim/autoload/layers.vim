vim9script

var job_queue = []
var max_jobs = 4
var running_jobs = 0
var plugins = {}
var jobs = []

import autoload "corefunctions.vim" as CF
import autoload "statusline.vim"
import autoload "logger.vim"

export def EnableLayers(list_of_packages: list<any>)

  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

  for package in list_of_packages
    var id = split(package.repository, '/')[1]
    plugins[id] = package

    if has_key(package, 'load')
      if package['load'] == 'now'
        AddJobToQueue(id)
      else
        AddLazyLoadJob(id)
      endif
    else
      AddJobToQueue(id)
    endif
  endfor

  var cache = 'layers.cache' #g:info
  writefile([printf("plugins = %s", plugins)], cache)
  writefile([printf("job_queue = %s", job_queue)], cache, 'a')
enddef

def AddLazyLoadJob(plugin: string)
  echom "adding " .. plugin .. " to lazyloadlojbs stack"
enddef

def AddJobToQueue(package_id: string)

  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

  var cmd = ['bash', '-c', $HOME .. '/.vim/pack/pack-manager '
    .. 'group ' .. plugins[package_id].group .. ' ; '
    .. $HOME .. '/.vim/pack/pack-manager install ' .. plugins[package_id].repository
    .. ' ' .. plugins[package_id].group .. ' ' .. plugins[package_id].opt]
  var opts = {}
  var job = {}

  opts.hidden = 1
  opts.out_msg = 0
  opts.vertical = 1
  opts.callback = 'JobOutput'
  opts.exit_cb = 'JobExit'
  # opts.term_finish = 'open'

  job = {
    'cmd': cmd,
    'opts': opts,
    'priority': plugins[package_id].priority,
  }
  add(job_queue, job)
  logger.Debug(printf("Add to job_queue the job: %s", cmd))
  CF.InfoNotification("Processing repository: " .. plugins[package_id].repository)
  timer_start(0, 'JobRunner')
enddef

def JobRunner(timer: number)

  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

  if len(job_queue) == 0
    if running_jobs == 0
      logger.Info('job_queue is empty, no more jobs left.')
      CF.InfoNotification("No more plugins waiting for install..")
    endif
    return
  endif

  if running_jobs >= max_jobs
    return
  endif

  # Sort jobs by priority level
  #var sorted_jobs = sort(job_queue, JobPriority)

  var job = remove(job_queue, 0)
  running_jobs += 1

  var cmd = job['cmd']
  var opts = job['opts']

  var job_id = term_start(cmd, opts)

  timer_start(10, 'JobRunner')

enddef

def JobPriority(job: dict<any>): number
  return job.priority
enddef

def JobOutput(channel: channel, msg: string)
  statusline.JobAddProgress()
  redrawstatus
enddef

def JobStop(): void
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

  running_jobs -= 1
  statusline.JobStop()
  timer_start(0, 'JobRunner')
enddef

def JobExit(job: job, status: number)
  var ch = job_getchannel(job)
  while ch_status(ch) ==# 'open' | sleep 1ms | endwhile
  while ch_status(ch) ==# 'buffered' | sleep 1ms | endwhile
  JobStop()
enddef

