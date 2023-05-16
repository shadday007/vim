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

    if IsPluginInstalled(id)
      ConfigPackage(id)
    else
      if has_key(package, 'load')
        if package['load'] == 'now'
          AddJobToQueue(id)
        else
          AddLazyLoadJob(id)
        endif
      else
        AddJobToQueue(id)
      endif
    endif
  endfor

  logger.Debug(printf("plugins = %s", plugins))
  logger.Debug(printf("job_queue = %s", job_queue))
enddef

def AddLazyLoadJob(plugin: string)
  echom "adding " .. plugin .. " to lazyloadlojbs stack"
enddef

def IsPluginInstalled(id: string): bool
  if g:layer_method == 'simple'
    return finddir(id, $HOME .. '/.vim/pack/**') != ""
  endif
  return index(g:installed_plugins, id) >= 0
enddef

def AddJobToQueue(package_id: string)

  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

  var config = plugins[package_id]
  var extra_cmd: string = ''
  var branch: string = ''
  var commit_or_tag: string = ''

  if has_key(config, 'commit_or_tag')
    branch = '#@:' .. config.commit_or_tag
  endif

  if has_key(config, 'branch')
    branch = '#b:' .. config.branch
  endif

  if has_key(config, 'do')
    extra_cmd = ' && ' .. config.do
  endif

  var cmd = ['bash', '-c', $HOME .. '/.vim/pack/pack-manager '
    .. 'group ' .. config.group .. ' ; '
    .. $HOME .. '/.vim/pack/pack-manager install ' .. config.repository
    .. branch .. commit_or_tag
    .. ' ' .. config.group .. ' ' .. config.opt
    .. extra_cmd]

  var opts = {}
  var job = {}

  opts.hidden = 1
  opts.out_msg = 0
  opts.vertical = 1
  opts.callback = 'JobOutput'
  opts.exit_cb = (j, e) => JobExit(package_id, j, e)
  # opts.term_finish = 'close'

  job = {
    'cmd': cmd,
    'opts': opts,
    'priority': plugins[package_id].priority,
    'job_id': package_id,
  }
  add(job_queue, job)
  logger.Debug(printf("Add to job_queue the job: %s", cmd))
  # CF.InfoNotification("Processing repository: " .. plugins[package_id].repository)
  timer_start(0, 'JobRunner')
enddef

def JobRunner(timer: number)

  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

  if len(job_queue) == 0
    if running_jobs == 0
      logger.Info('job_queue is empty, no more jobs left.')
      # CF.InfoNotification("No more plugins waiting for install..")
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

def JobExit(id: string, job: job, status: number)
  var ch = job_getchannel(job)
  while ch_status(ch) ==# 'open' | sleep 1ms | endwhile
  while ch_status(ch) ==# 'buffered' | sleep 1ms | endwhile
  JobStop()
  ConfigPackage(id)
enddef

def ConfigPackage(plugin: string)
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

  var config = plugins[plugin]
  if has_key(config, 'beforeload')
    for item in config.beforeload
      execute item
    endfor
  endif

  execute 'packadd ' .. plugin

  if has_key(config, 'afterload')
    for item in config.afterload
      execute item
    endfor
  endif
enddef
