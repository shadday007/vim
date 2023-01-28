vim9script

g:git_infos = {'dir': '', 'branch': '', 'prev_dir': '', 'is_root': false}
var git = g:git_infos

var is_fugitive = exists('g:loaded_fugitive')
var is_gui = has('gui_running')
var ispadding: bool = false
var show_syntax: bool = false
var blur_window: bool = false
var Cap_indicator: string = ''
var Cap_flag: string = ''
var Num_indicator: string = ''
var Num_flag: string = ''

var Path = (p): string => has('win32') ? substitute(p, '\\\ze[^ ]', '/', 'g') : p
var GitDir = (): string => is_fugitive  ? substitute(g:FugitiveGitDir(), '.\.git$', '', '') : getcwd()

var left_separator = ''
var right_separator = ''

var lhs_color = 'Folded'
var async_color = 'Constant'
var modified_color = 'Identifier'
var status_highlight = lhs_color
var async = 0

var hi_stl = '%1* '
var hi_branch = '%2* '
var hi_fname = '%3* '
var hi_lseparator = '%4*'
var hi_rhs = '%5* '
var hi_lhs = '%7* '
var hi_rseparator = '%8*'
var hi_warning   = '%9* '

var Normal  = '%7* '
var Insert  = '%9* '
var Replace = '%5* '
var Visual  = '%6* '
var Command = '%2* '

var colors = {
  'n':      Normal,
  'i':      Insert,
  'v':      Visual,
  'V':      Visual,
  "\<C-V>": Visual,
  'R':      Replace,
  's':      Insert,
  'S':      Insert,
  "\<C-s>": Insert,
  'c':      Command,
  't':      Command,
}

var modes = {
  'n':      'N ',
  'i':      'I ',
  'v':      'V ',
  'V':      'V-L ',
  "\<C-V>": 'V-B ',
  'R':      'R ',
  's':      'S ',
  'S':      'S-L ',
  "\<C-s>": 'S-B ',
  'c':      'C ',
  't':      'T ',
}

var insmode = {
  'n':      false,
  'i':      true,
  'v':      false,
  'V':      false,
  "\<C-V>": false,
  'R':      true,
  's':      true,
  'S':      true,
  "\<C-s>": true,
  'c':      true,
  't':      false,
}

var special_bufnames = {
  '^fugitive:': (): string => {
    return ' fugitive: ' .. hi_stl .. GitDir()
  },
  ' --graph$':  (): string => ' Git graph ' .. hi_stl .. GitDir()
}

var special_filetypes = {
  'gitcommit': (): string => ' Commit ' .. hi_stl .. GitDir(),
  'fugitive':  (): string => ' Git Status ' .. hi_stl .. GitDir(),
  'startify':  (): string => ' Startify ',
  'netrw':     (): string => ' Netrw ' .. expand('%:t'),
  'dirvish':   (): string => ' Dirvish ' .. hi_stl .. expand('%:~'),
  'command-t': (): string => '\ \ ' .. substitute(bufname('%'), ' ', '\\ ', 'g'),
  'help':      (): string => &ro ? ' HELP ' .. hi_stl .. expand('%:t') : '',
}

var Unlisted = (): string => ' UNLISTED %1* %f%=%0* %4l:%-4c'
var Scratch  = (s): string => ' ' .. toupper(s) .. ' ' .. hi_stl .. '%f%'
var Preview  = (): string => ' PREVIEW %1* %f%=%0* %4l:%-4c'
var Inactive = (): string => '%#StatuslineNC# %f %m%r%= %p%% ｜ %l:%c '

var LeftSeparator = (): string => hi_lseparator .. left_separator
var RightSeparator = (): string => hi_rseparator .. right_separator .. hi_rhs
var Show_syntax = (): string => show_syntax ? 'Ⓢ ' ..  synIDattr(synID(line('.'), col("."), 1), "name") .. ' ' : ''
var Line_height = (): string => 'Ⓛ ' .. line('.') .. '/' .. line('$') .. ' '
var Column_width = (): string => 'Ⓒ ' .. virtcol('.') .. '/' .. virtcol('$') .. ' '
var Page_pages = (): string => 'ⓟ ' .. (line('.') / winheight(0) + 1) .. '/' .. (line('$') / winheight(0) + 1) .. ' '
var Git_branch = (): string => insmode[mode()] || git.branch == '' ? '' : (git.is_root ? hi_branch : hi_warning) .. git.branch
var Local_dir = (): string => haslocaldir() == 1 ? hi_warning .. 'L ' : haslocaldir() == 2 ? hi_warning .. 'T ' : ''

export def CapStatus(): void
  silent g:caps_lock = systemlist('xset -q | awk ''/00:/{print $4}''')[0] == 'on'
  if get(g:, 'caps_lock', false)
    Cap_indicator = ' '
    Cap_flag = trim(hi_warning) .. 'CAPS '
  else
    Cap_indicator = ''
    Cap_flag = ''
  endif
enddef

export def NumStatus(): void
  silent g:num_lock = systemlist('xset -q | awk ''/00:/{print $8}''')[0] == 'on'
  if !get(g:, 'num_lock', true)
    Num_indicator = 'off '
    Num_flag = trim(hi_warning) .. 'NUM '
  else
    Num_indicator = ''
    Num_flag = ''
  endif
enddef

def Lhs(): string
  var lhs: string = hi_lhs
  if ispadding
    lhs ..= Gutterpadding()
  endif

  lhs ..= BufnrWinnr() .. ReadOnly() .. IsModified() .. Cap_indicator .. Num_indicator

  lhs ..= LeftSeparator()
  return lhs
enddef

def Rhs(): string
  var rhs = RightSeparator()

  if winwidth(0) > 80
    var padding = len(line('$')) - len(line('.'))
    if ( padding > 0 )
      rhs ..= repeat(' ', padding)
    endif

    rhs ..= Line_height() .. Column_width() .. Page_pages() .. Show_syntax() .. Warn()

    if len(virtcol('.')) < 2
      rhs ..= ' '
    endif
    if len(virtcol('$')) < 2
      rhs ..= ' '
    endif
  endif
  return rhs
enddef

def Flags_group(): string
  var Flags = ''

  Flags ..= &ro         ? 'RO ' : ''
  Flags ..= &paste      ? 'PASTE ' : ''
  Flags ..= &spell      ? &spelllang .. ' ' : ''

  Flags ..= Cap_flag .. Num_flag

  Flags ..= &buftype != '' ? hi_warning .. toupper(&buftype) .. ' '
    : &mod ? trim(hi_warning) .. 'MODIFIED' .. hi_stl : ''

  Flags ..= Ft() .. Fenc()

  if Flags != ''
    Flags =  trim(hi_stl) .. ' [' .. trim(Flags) .. trim(hi_stl) .. ']'
  endif
  return Flags
enddef

def Active(): string
  var Color = colors[mode()]
  var Mode = Color .. modes[mode()]
  var Flags = Flags_group()

  if insmode[mode()]
    return Mode .. Lhs() .. hi_fname .. '%f' .. Flags .. '%=' .. &ft .. ' ' .. Color .. ' %l:%c '
  endif

  return Mode .. Git_branch() .. Lhs() .. hi_fname .. ShortBufname() .. Flags
    .. '%=' .. Local_dir() .. Session() .. Rhs()
enddef

def g:Statusline(): string
  var w = g:statusline_winid
  var custom = SpecialBufname(w) ?? SpecialFiletype(w)

  if custom != ''
    return custom
  elseif !getwinvar(w, '&buflisted')
    return Unlisted()
  elseif getwinvar(w, '&buftype') != ''
    return Scratch(getwinvar(w, '&buftype'))
  elseif getwinvar(w, '&previewwindow')
    return Preview()
  elseif w != win_getid()
    return Inactive()
  else
    return Active()
  endif
enddef

def SpecialBufname(w: number): string
  for b in keys(special_bufnames)
    if bufname(winbufnr(w)) =~ b
      var sl = special_bufnames[b]()
      if sl != ''
        return sl .. '%=' .. hi_rhs .. ' %l:%c '
      endif
      break
    endif
  endfor
  return ''
enddef

def SpecialFiletype(w: number): string
  for ft in keys(special_filetypes)
    if getwinvar(w, '&ft') == ft
      var sl = special_filetypes[ft]()
      if sl != ''
        return sl .. '%=' .. hi_rhs .. ' %l:%c '
      endif
      break
    endif
  endfor
  return ''
enddef

def Fileprefix(): string
  var basename = expand('%:h')
  if basename ==# '' || basename ==# '.'
    return ''
  elseif has('modify_fname')
    # Make sure we show $HOME as ~.
    return substitute(fnamemodify(basename, ':~:.'), '/$', '', '') .. '/'
  else
    # Make sure we show $HOME as ~.
    return substitute(basename .. '/', '\C^' .. $HOME, '~', '')
  endif
enddef

def ShortBufname(): string
  var fn = Fileprefix() .. expand('%:t')
  if strlen(fn) < winwidth(0) / 2 || fn !~ '/'
    return Fileprefix() .. expand('%:t')
  endif
  var path = substitute(fn, '\v%((\.?[^/])[^/]*)?/(\.?[^/])[^/]*', '\1/\2', 'g')
  path = path[ : -2] .. fnamemodify(fn, ':t')
  if strlen(path) < winwidth(0) / 2
    return path
  endif
  path = fnamemodify(fn, ':p')
  return '...' .. strpart(path, len(path) - winwidth(0) / 3)
enddef

def Session(): string
  if empty(v:this_session)
    return ''
  endif
  var ob = exists('g:loaded_obsession') && exists('g:this_obsession')
  var ss = fnamemodify(ob ? g:this_obsession : v:this_session, ':t')
  var hl = ob ? g:ObsessionStatus() != '[$]' ? 'diffRemoved' : 'diffAdded' : 'Special'
  return printf('%%#%s# %s ', hl, ss)
enddef

def Warn(): string
  if exists('b:sl_warnings')
    return b:sl_warnings
  elseif !&ma || exists('SessionLoad')
    return ''
  endif

  var size    = getfsize(@%)
  var large   = size == -2 || size > 20 * 1024 * 1024
  var trail   = index(['markdown'], &ft) >= 0 ? 0 : search('\s$', 'cnw')
  var mixed   = 0

  var noMix = get(g:, 'no_mixed_indent', ['vim', 'sh', 'python', 'go'])

  if index(noMix, &ft) >= 0
    var tabs    = search('^\s\{-}\t', 'cnw')
    var spaces  = search('^\s\{-} ', 'cnw')
    mixed       = tabs > 0 || spaces > 0 ? &expandtab ? tabs : spaces : 0
  endif

  if large || trail > 0 || mixed > 0
    if winwidth(0) < 140
      b:sl_warnings = hi_warning .. '⚑'
    else
      b:sl_warnings = hi_warning .. join(
        ( large     ? ['Large file '] : [] ) +
        ( trail > 0 ? ['Trailing space (' .. trail .. ') '] : [] ) +
        ( mixed > 0 ? ['Mixed indent (' .. mixed .. ') '] : [] ), '|'
      )
    endif
  else
    b:sl_warnings = ''
  endif
  return b:sl_warnings
enddef

export def GitInfo(): void
  if !is_fugitive || exists('g:SessionLoad')
    return
  endif

  var sha = g:FugitiveHead(8)

  if empty(sha)
    git.branch = ''
    return
  endif

  git.branch = printf(' %s ', sha)
  git.dir = Path(GitDir())
  git.is_root = Path(getcwd()) == git.dir
enddef

def BufnrWinnr(): string
  var lbufnr: any = bufnr('%')
  if !is_gui
    lbufnr = lbufnr > 20 ? lbufnr : nr2char(9311 + lbufnr) .. ' '
  endif
  return ' ' .. bufnr('%') .. ' 🗗 ' .. winnr() .. ' '
enddef

def Gutterpadding(): string
  var width_scl = 0
  if exists('+signcolumn')
    if &signcolumn == 'yes'
      width_scl = 2
    elseif &signcolumn == 'auto'
      var signs = ''
      if exists('*execute')
        signs = execute('sign place buffer=' .. bufnr('$'))
      else
        signs = ''
        silent! redir => signs
        silent execute 'sign place buffer=' .. bufnr('$')
        redir END
      endif
      if match(signs, 'line=') != -1
        width_scl = 2
      endif
    endif
  endif

  var minwidth = 2
  var gutterWidth = max([strlen(line('$')) + 1, &numberwidth, minwidth]) + width_scl
  return repeat(' ', gutterWidth - 1)
enddef

def Ft(): string
  if strlen(&ft) > 0
    return trim(hi_stl) .. &ft
  else
    return ''
  endif
enddef

def Fenc(): string
  var Ff = &ff == 'unix' ? '' : hi_rhs .. &ff .. ' '
  if strlen(&fenc) > 0 && &fenc !=# 'utf-8'
    return Ff .. hi_rhs .. &fenc .. ' '
  else
    return Ff .. ''
  endif
enddef

def IsModified(): string
  var lmo: string = ''
  if &modified
    lmo = '🗶 '
  endif
  return lmo
enddef

def ReadOnly(): string
  var lro: string = ''
  if &readonly || !&modifiable
    lro = ' '
  endif
  return lro
enddef

def Get_spell_settings(): dict<any>
  return {
    'spell': &l:spell,
    'spellcapcheck': &l:spellcapcheck,
    'spellfile': &l:spellfile,
    'spelllang': &l:spelllang
  }
enddef

def Set_spell_settings(settings: dict<any>)
  &l:spell = settings.spell
  &l:spellcapcheck = settings.spellcapcheck
  &l:spellfile = settings.spellfile
  &l:spelllang = settings.spelllang
enddef

export def Blur_window()
  if blur_window
    var settings = Get_spell_settings()
    ownsyntax off
    # &l:colorcolumn = join(range(1, 255), ',')
    set nolist
    if has('conceal')
      set conceallevel=0
    endif
    Set_spell_settings(settings)
  endif
enddef

export def Focus_window()
  if blur_window
    if !empty(&ft)
      var settings = Get_spell_settings()
      ownsyntax on
      # &l:colorcolumn = '+' .. join( range( 0, 254 ), ',+' )
      set list
      if has('conceal')
        set conceallevel=1
      endif
      Set_spell_settings(settings)
    endif
  endif
enddef

export def Check_modified()
  if &modified && status_highlight != modified_color
    status_highlight = modified_color
    Update_highlight()
  elseif !&modified
    if async && status_highlight != async_color
      status_highlight = async_color
      Update_highlight()
    elseif !async && status_highlight != lhs_color
      status_highlight = lhs_color
      Update_highlight()
    endif
  endif
enddef

export def Update_highlight()

  # Update StatusLine to use italics (used for filetype).
  var highlight = pinnacle#italicize('StatusLine')
  execute 'highlight User1 ' .. highlight

  # Update DiffText to use italics (used for branch name).
  highlight = pinnacle#italicize('DiffAdd')
  execute 'highlight User2 ' .. highlight

  # StatusLine + bold (used for file names).
  highlight = pinnacle#embolden('StatusLine')
  execute 'highlight User3 ' .. highlight

  # And opposite for the buffer number area.
  var fg = pinnacle#extract_fg(status_highlight)
  var bg = pinnacle#extract_bg('StatusLine')
  execute 'highlight User7 ' ..
    pinnacle#highlight({
      'bg': fg,
      'fg': pinnacle#extract_fg('Normal'),
      'term': 'bold'
    })

  # Inverted Error styling, for left-hand side 'Powerline' triangle.
  execute 'highlight User4 ' .. pinnacle#highlight({'bg': bg, 'fg': fg})

  # Right-hand side section.
  bg = pinnacle#extract_fg('Cursor')
  fg = pinnacle#extract_fg('User3')
  execute 'highlight User5 ' ..
    pinnacle#highlight({
      'bg': fg,
      'fg': bg,
      'term': 'bold'
    })

  # used only for visual mode
  execute 'highlight User6 ' ..
    pinnacle#highlight({
      'bg': pinnacle#extract_fg('DiffText'),
      'fg': pinnacle#extract_fg('Cursor'),
      'term': 'bold,italic'
    })

  # Inverted Error styling, for right-hand side 'Powerline' triangle.
  var Bfg = pinnacle#extract_fg('User3')
  var Bbg = pinnacle#extract_bg('StatusLine')
  execute 'highlight User8 ' .. pinnacle#highlight({'bg': Bbg, 'fg': Bfg})

  # for warning
  execute 'highlight User9 ' ..
    pinnacle#highlight({
      'bg': pinnacle#extract_bg('StatusLine'),
      'fg': pinnacle#extract_fg('WarningMsg'),
      'cterm': 'bold,italic'
    })
  highlight = pinnacle#italicize('User9')
  execute 'highlight User9 ' .. highlight

  highlight clear StatusLineNC
  highlight! link StatusLineNC User1
enddef
