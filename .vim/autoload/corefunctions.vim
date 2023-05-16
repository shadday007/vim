vim9script

import autoload "logger.vim"

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

export def ErrorNotification(msg: string): void
  var pop_opts = {
    title: ' Error ',
    pos: 'center',
    time: 4000,
    padding: [1, 2],
    highlight: 'User9',
    borderhighlight: ['User9'],
    borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
    border: []
  }
  popup_notification('[vim]-> ' .. msg, pop_opts)
enddef

export def WarningNotification(msg: string): void
  var pop_opts = {
    title: ' Warning ',
    pos: 'center',
    time: 3000,
    padding: [1, 2],
    highlight: 'TabLineSel',
    borderhighlight: ['PmenuSel'],
    borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
    border: []
  }
  popup_notification('[vim]-> ' .. msg, pop_opts)
enddef

export def InfoNotification(msg: string): void
  var pop_opts = {
    title: ' Info ',
    line: (&lines - 6),
    col: (&columns - len(msg) - 10),
    time: 2000,
    padding: [1, 2],
    highlight: 'ModeMsg',
    borderhighlight: ['Title'],
    borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
    border: []
  }
  popup_notification('[vim]-> ' .. msg, pop_opts)
enddef

export def GetOppositeColor(bg_color: string): string
  var rgb_bg = strpart(substitute(bg_color, '#', '', ''), -6)

  var fg_color = printf("%02X%02X%02X", 255 - str2nr(strpart(rgb_bg, 0, 2), 16),
    255 - str2nr(strpart(rgb_bg, 2, 2), 16),
    255 - str2nr(strpart(rgb_bg, 4, 2), 16))

  # return CorrectContrast(bg_color, fg_color)
  return GetContrastColor(bg_color)
enddef

def CorrectContrast(bg_color: string, fg_color: string): string

  var bg_luminance = GetLuminance(bg_color)
  var fg_luminance = GetLuminance(fg_color)
  var l1 = max([float2nr(bg_luminance), float2nr(fg_luminance)])
  var l2 = min([float2nr(bg_luminance), float2nr(fg_luminance)])
  var ratio = (l1 + 0.05) / (l2 + 0.05)

  if ratio >= 4.5
    return fg_color
  endif

  # Calculate new foreground color with corrected contrast
  var new_fg_color = ""
  var fg_part: number
  var new_fg_part: number
  var hex_str: string
  var ratio: float
  if bg_luminance > fg_luminance
    ratio = (bg_luminance + 0.05) / (fg_luminance + 0.05)
    for i in range(1, 3)
      fg_part = str2nr(strpart(fg_color, i * 2 - 1, 2), 16)
      new_fg_part = max([0, min([255, float2nr(round(fg_part * ratio))])])
      hex_str = printf("%02X", new_fg_part)
      new_fg_color ..= hex_str
    endfor
  else
    ratio = (fg_luminance + 0.05) / (bg_luminance + 0.05)
    for i in range(1, 3)
      fg_part = str2nr(strpart(fg_color, i * 2 - 1, 2), 16)
      new_fg_part = max([0, min([255, float2nr(round(fg_part / ratio))])])
      hex_str = printf("%02X", new_fg_part)
      new_fg_color ..= hex_str
    endfor
  endif

  return '#' .. new_fg_color
enddef

# Calculates the adjusted contrast ratio based on WCAG 2.1
def GetAdjustedRatio(contrast_ratio: float): float
  if contrast_ratio < 3.0
    return 4.5
  elseif contrast_ratio < 4.5
    return (contrast_ratio + 0.05) * 1.2
  else
    return contrast_ratio
  endif
enddef

export def GetContrastColor(bg_color: string): string

  var rgb_bg = strpart(substitute(bg_color, '#', '', ''), -6)

  # Calculate the brightness of the background color
  var brightness = (str2nr(strpart(rgb_bg, 0, 2), 16) * 299 +
    str2nr(strpart(rgb_bg, 2, 2), 16) * 587 +
    str2nr(strpart(rgb_bg, 4, 2), 16) * 114) / 1000

  var rgb_fg = brightness > 128 ? '000000' : 'f0f0f0'

  return '#' .. rgb_fg
enddef

# Helper function to calculate relative luminance of a color
def GetLuminance(color: string): float

  var rgb = strpart(substitute(color, '#', '', ''), -6)

  # Convert hex color code to RGB values using strpart() function
  var r = str2nr('0x' .. strpart(rgb, 1, 2), 16) / 255.0
  var g = str2nr('0x' .. strpart(rgb, 3, 2), 16) / 255.0
  var b = str2nr('0x' .. strpart(rgb, 5, 2), 16) / 255.0

  var r_prime: float
  var g_prime: float
  var b_prime: float
  # Calculate relative luminance based on formula from W3C guidelines
  if r <= 0.03928
    r_prime = r / 12.92
  else
    r_prime = pow(((r + 0.055) / 1.055), 2.4)
  endif
  if g <= 0.03928
    g_prime = g / 12.92
  else
    g_prime = pow(((g + 0.055) / 1.055), 2.4)
  endif
  if b <= 0.03928
    b_prime = b / 12.92
  else
    b_prime = pow(((b + 0.055) / 1.055), 2.4)
  endif

  var luminance = 0.2126 * r_prime + 0.7152 * g_prime + 0.0722 * b_prime

  return luminance
enddef

# argument plugin is the vim plugin's name
export def IsDir(plugin: string): bool
  InfoMsg(plugin)
  return isdirectory(expand(plugin)) ? true : false
enddef

def GetDirDict(dir_path: list<string>): dict<any>
  var dir_dictionary = {}
  var dir_name: string
  var subdirs: list<string>
  var subdirs_list: list<string>

  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.\|\s\)', '', ''))
  for dir in dir_path
    dir_name = fnamemodify(dir, ":t")
    subdirs = split(globpath(dir, '*'), '\n')
    subdirs = filter(subdirs, 'isdirectory(v:val)')
    subdirs_list = map(subdirs, 'fnamemodify(v:val, ":t")')

    if has_key(dir_dictionary, dir_name)
      extend(dir_dictionary[dir_name], subdirs_list)
    else
      dir_dictionary[dir_name] = subdirs_list
    endif
  endfor
  logger.Debug(printf("dir_dictionary = %s", dir_dictionary))
  return dir_dictionary
enddef

export def GetTopics(): dict<any>
  var topics_base = expand( $HOME .. '/.vim/autoload/layers' )
  var topics_dir = split(globpath(topics_base, '*'), '\n')
  var topics_path = filter(topics_dir, 'isdirectory(v:val)')

  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))
  logger.Debug('var topics_base: ' .. topics_base)
  return GetDirDict(topics_path)
enddef

export def GetAllPlugins(): dict<any>
  var install_path = finddir( "start", $HOME .. '/.vim/pack/**2', -1)
  extend(install_path, finddir( "opt", $HOME .. '/.vim/pack/**1', -1))

  return GetDirDict(install_path)
enddef

export def Ask(message: string): number
  inputsave()
  echohl WarningMsg
  var answer = input(message .. ' (y/N) ')
  echohl None
  inputrestore()
  echo "\r"
  return (0 && answer =~? '^a') ? 2 : (answer =~? '^y') ? 1 : 0
enddef
