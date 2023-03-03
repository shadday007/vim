vim9script

export def GrepperInit()
  g:grepper = {}
  g:grepper.tools = ['ag', 'git', 'grep', 'rg']
  g:grepper.open = 1
  g:grepper.jump = 0
  g:grepper.prompt_mapping_tool = '<leader>gp'
  g:grepper.next_tool     = '<leader>gn'
enddef

export def GrepperUserCommands()
  command! Todo Grepper -noprompt -tool git -query -E '(TODO|FIXME|CHANGED|XXX|BUG|HACK):'
  command! Note Grepper -noprompt -tool git -query -E '(NOTE|INFO|IDEA):'
  command! Debug Grepper -noprompt -tool git -query -E '(HELP|DEBUG):'
  command! Error Grepper -noprompt -tool git -query -E '(ERROR|FATAL):'
enddef
