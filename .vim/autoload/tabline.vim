vim9script

var time = ''
var file_node_extensions = {
   'rust': '',
   'styl': '',
   'scss': '',
   'htm': '',
   'html': '',
   'erb': '',
   'slim': '',
   'ejs': '',
   'wxml': '',
   'css': '',
   'less': '',
   'wxss': '',
   'md': '',
   'markdown': '',
   'json': '',
   'js': '',
   'jsx': '',
   'rb': '',
   'php': '',
   'py': '',
   'pyc': '',
   'pyo': '',
   'pyd': '',
   'coffee': '',
   'mustache': '',
   'hbs': '',
   'conf': '',
   'ini': '',
   'yml': '',
   'bat': '',
   'jpg': '',
   'jpeg': '',
   'bmp': '',
   'png': '',
   'gif': '',
   'ico': '',
   'twig': '',
   'cpp': '',
   'c++': '',
   'cxx': '',
   'cc': '',
   'cp': '',
   'c': '',
   'hs': '',
   'lhs': '',
   'lua': '',
   'java': '',
   'sh': '',
   'fish': '',
   'ml': 'λ',
   'mli': 'λ',
   'diff': '',
   'db': '',
   'sql': '',
   'dump': '',
   'clj': '',
   'cljc': '',
   'cljs': '',
   'edn': '',
   'scala': '',
   'go': '',
   'dart': '',
   'xul': '',
   'sln': '',
   'suo': '',
   'pl': '',
   'pm': '',
   't': '',
   'rss': '',
   'f#': '',
   'fsscript': '',
   'fsx': '',
   'fs': '',
   'fsi': '',
   'rs': '',
   'rlib': '',
   'd': '',
   'erl': '',
   'hrl': '',
   'vim': '',
   'ai': '',
   'psd': '',
   'psb': '',
   'ts': '',
   'tsx': '',
   'jl': ''
}

var file_node_exact_matches = {
   'exact-match-case-sensitive-1.txt': 'X1',
   'exact-match-case-sensitive-2': 'X2',
   'gruntfile.coffee': '',
   'gruntfile.js': '',
   'gruntfile.ls': '',
   'gulpfile.coffee': '',
   'gulpfile.js': '',
   'gulpfile.ls': '',
   'dropbox': '',
   '.ds_store': '',
   '.gitconfig': '',
   '.gitignore': '',
   '.bashrc': '',
   '.bashprofile': '',
   'favicon.ico': '',
   'license': '',
   'node_modules': '',
   'react.jsx': '',
   'Procfile': '',
   '.vimrc': '',
}

var file_node_pattern_matches = {
  '.*jquery.*\.js$': '',
  '.*angular.*\.js$': '',
  '.*backbone.*\.js$': '',
  '.*require.*\.js$': '',
  '.*materialize.*\.js$': '',
  '.*materialize.*\.css$': '',
  '.*mootools.*\.js$': ''
}

export def Update_highlight()
  highlight! link TabNum User1
  highlight! link TabNumSel User7

  highlight! link WinNum User1
  var fg: string = synIDattr(synIDtrans(hlID("ToolbarButton")), "fg")
  var bg: string = synIDattr(synIDtrans(hlID("PmenuSel")), "bg")
  execute 'highlight WinNumSel ' ..
    pinnacle#highlight({
      'bg': bg,
      'fg': fg
    })

  fg = synIDattr(synIDtrans(hlID("WarningMsg")), "fg")
  bg = synIDattr(synIDtrans(hlID("PmenuSel")), "bg")
  execute 'highlight TabLineSel ' ..
    pinnacle#highlight({
      'bg': bg,
      'fg': fg
    })
  highlight! link TabLine User1

  highlight! link TabLineFill User3
enddef

def GetFileIcon(path: string): string
  var file = fnamemodify(path, ':t')
  if has_key(file_node_exact_matches, file)
    return file_node_exact_matches[file]
  endif
  for [k, v]  in items(file_node_pattern_matches)
    if match(file, k) != -1
      return v
    endif
  endfor
  var ext = fnamemodify(file, ':e')
  if has_key(file_node_extensions, ext)
    return file_node_extensions[ext]
  endif
  return ''
enddef

def g:MyTabLine(): string
    var s = ''
    var t = tabpagenr()
    var i = 1
    while i <= tabpagenr('$')
        var buflist = tabpagebuflist(i)
        var winnr = tabpagewinnr(i)
        var bufnr = buflist[winnr - 1]
        var buftype = getbufvar(bufnr, '&buftype')
        var bufname = bufname(bufnr)
        var full_path = fnamemodify(bufname, ':p')
        var icon = GetFileIcon(full_path)
        var nwins = tabpagewinnr(i, '$')

        s ..= '%' .. i .. 'T'

        s ..= (i == t ? '%#TabNumSel#' : '%#TabNum#')
        s ..= ' ' .. i .. ' '

        s ..= (i == t ? '%#TabLineSel#' : '%#TabLine#')

        if buftype == 'help'
            bufname = 'help:' .. fnamemodify(bufname, ':t:r')

        elseif buftype == 'quickfix'
            bufname = 'quickfix'

        elseif buftype == 'nobufname'
            if bufname =~ '\/.'
                bufname = substitute(bufname, '.*\/\ze.', '', '')
            endif

        else
            bufname = pathshorten(fnamemodify(bufname, ':p:~:.'))
            if getbufvar(bufnr, '&modified')
                bufname = '[+]' .. bufname
            endif

        endif

        if bufname == ''
            bufname = '[No Name]'
        else
          bufname = icon .. ' ' .. bufname
        endif

        s ..= ' ' .. bufname

        if nwins > 1
            var is_modified = ''
            for b in buflist
                if getbufvar(b, '&modified') && b != bufnr
                    is_modified = '*'
                    break
                endif
            endfor
            var hl = (i == t ? '%#WinNumSel#' : '%#WinNum#')
            var nohl = (i == t ? '%#TabLineSel#' : '%#TabLine#')
            s ..= ' ' .. is_modified .. '(' .. hl .. winnr .. nohl .. '/' .. nwins .. ')'
        endif

        if i < tabpagenr('$')
            s ..= ' %#TabLine#|'
        else
            s ..= ' '
        endif

        i = i + 1
    endwhile

    s ..= '%T%#TabLineFill#%='
    s ..= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s

enddef
