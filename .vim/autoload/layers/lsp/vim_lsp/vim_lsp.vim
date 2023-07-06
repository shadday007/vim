vim9script

import autoload "corefunctions.vim" as CF
import autoload "layers.vim"
import autoload "logger.vim"

def Plugins(): list<any> # A.K.A. Packages

  var plugins: list<any> = [
    {
      'repository': 'dense-analysis/ale',
      'load': 'now',
      'priority': 0,
      'group': 'lsp',
      'opt': 'opt',
      'beforeload': [
      'layers#lsp#vim_lsp#vim_lsp#ALEConfig()',
      ],
    },
    {
      'repository': 'prabirshrestha/vim-lsp',
      'load': 'now',
      'priority': 0,
      'group': 'lsp',
      'opt': 'opt',
      'beforeload': [
      'layers#lsp#vim_lsp#vim_lsp#LspConfig()',
      ],
      'afterload': [
      'layers#lsp#vim_lsp#vim_lsp#LspAfter()',
      ]
    },
    {
      'repository': 'rhysd/vim-lsp-ale',
      'load': 'now',
      'priority': 0,
      'group': 'lsp',
      'opt': 'opt',
    },
    {
      'repository': 'prabirshrestha/asyncomplete.vim',
      'load': 'now',
      'priority': 0,
      'group': 'lsp',
      'opt': 'opt',
    # 'beforeload': [
    # "g:asyncomplete_auto_popup = 0",
    # ],
    },
    {
      'repository': 'prabirshrestha/asyncomplete-lsp.vim',
      'load': 'now',
      'priority': 0,
      'group': 'lsp',
      'opt': 'opt',
    },
    {
      'repository': 'mattn/vim-lsp-settings',
      'load': 'now',
      'priority': 0,
      'group': 'lsp',
      'opt': 'opt',
    },
    {
      'repository': 'rafamadriz/friendly-snippets',
      'load': 'now',
      'priority': 0,
      'group': 'lsp',
      'opt': 'opt',
    },
    {
      'repository': 'hrsh7th/vim-vsnip',
      'load': 'now',
      'priority': 0,
      'group': 'lsp',
      'opt': 'opt',
      'beforeload': [
      "g:vsnip_snippet_dir = expand('~/.vim/snippets/')",
      "g:vsnip_snippet_dirs = split(globpath(&runtimepath, 'snippets'), '\n')",
      ],
      'afterload': [
      'layers#lsp#vim_lsp#vim_lsp#LspVsnipConfig()',
      ]
    },
    {
      'repository': 'hrsh7th/vim-vsnip-integ',
      'load': 'now',
      'priority': 0,
      'group': 'lsp',
      'opt': 'opt',
      'afterload': [
      'call vsnip_integ#integration#attach()',
      ]
    },
  ]
  return plugins
enddef

export def SetupLayer()
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

  var layers_packages: list<any> = Plugins()
  layers.EnableLayers(layers_packages)
enddef

export def LspConfig()
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

  g:lsp_semantic_enabled = 1
  # Gutter symbols
  g:lsp_document_code_action_signs_enabled = 1
  g:lsp_document_code_action_signs_hint = {'text': '→'}
  g:lsp_diagnostics_signs_error = { 'text': '' }
  g:lsp_diagnostics_signs_warning = { 'text': '' }
  g:lsp_diagnostics_signs_information = {'text': 'ℹ'}
  g:lsp_diagnostics_signs_hint = {'text': '?'}
  g:lsp_document_code_action_signs_hint = { 'text': '' }
  g:lsp_tree_incoming_prefix = "⬅️  "
  g:lsp_diagnostics_signs_insert_mode_enabled = 0 # Please don't bother me while I type
enddef

export def LspFunctions()
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))
enddef

export def LspAfter()
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

  augroup lsp_install
    au!
    # call on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled On_lsp_buffer_enabled()
  augroup END
enddef

export def ALEConfig()
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

  g:ale_fix_on_save = 1
  g:ale_lint_on_insert_leave = 1

  g:ale_sign_error = '✖'
  g:ale_sign_warning = '➤'
  g:ale_sign_info = "ⓘ"
  g:ale_virtualtext_cursor = 1
  g:ale_virtualtext_prefix = "🔥 "

  g:ale_set_quickfix = 1

  g:ale_completion_symbols = {
    'text': '',
    'method': '',
    'function': '',
    'constructor': '',
    'field': 'ﴲ',
    'variable': '',
    'class': '',
    'interface': '',
    'module': '',
    'property': '',
    'unit': '',
    'value': '',
    'enum': '練',
    'keyword': '',
    'snippet': '',
    'color': '',
    'file': '',
    'reference': '',
    'folder': '',
    'enum_member': '',
    'constant': 'ﲀ',
    'struct': 'ﳤ',
    'event': '',
    'operator': '',
    'type_parameter': '',
    '<default>': 'v'
  }

  g:ale_linters = {
    'c': ['clang'],
    'cpp': ['clang'],
    'go': ['gopls', 'gofmt'],
    'h': ['clang'],
    'javascript': ['eslint'],
    'python': ['pylint', 'flake8'],
    'typescript': ['prettier'],
    'ruby': ['standardrb', 'rubocop'],
    'rust': ['rustfmt'],
    'vue': ['eslint', 'stylelint', 'vls'],
    'vuejs': ['eslint', 'stylelint', 'vls'],
    'svelte': ['eslint'],
  }

  g:ale_fixers = {
    '*': ['remove_trailing_lines', 'trim_whitespace'],
    'c': ['clang-format'],
    'cpp': ['clang-format'],
    'go': ['gofmt', 'goimports'],
    'h': ['clang-format'],
    'javascript': ['prettier', 'eslint'],
    'python': ['black'],
    'typescript': ['prettier', 'eslint', 'tslint'],
    'ruby': ['rubocop'],
    'rust': ['rustfmt'],
    'vue': ['prettier'],
    'vuejs': ['prettier'],
    'svelte': ['prettier'],
    'sh': ['shfmt'],
  }

  if isdirectory('/usr/local/llvm12')
    g:ale_c_clangd_executable = '/usr/local/bin/clang-format12'
    g:ale_c_clangformat_executable = '/usr/local/bin/clang-format12'
  endif
enddef

def On_lsp_buffer_enabled()
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))

  setlocal signcolumn=yes

  if exists('+tagfunc')
    setlocal tagfunc=lsp#tagfunc
  endif

  if exists('g:loaded_vsnip_integ')
    inoremap <expr> <Tab> HandleTab()
    inoremap <buffer><expr> <S-Tab> HandleShiftTab()
    inoremap <expr><silent> <CR> HandleEnter()
    snoremap <expr> <Tab> HandleTab()
    snoremap <buffer><expr> <S-Tab> HandleShiftTab()
    snoremap <expr><silent> <CR> HandleEnter()
  else
    imap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
    imap <expr><silent> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
  endif

  nmap gh <plug>(lsp-document-symbol-search)
  nmap gH <plug>(lsp-workspace-symbol-search)

  nmap <leader>ca <plug>(lsp-code-action-float)
  vmap <leader>ca <plug>(lsp-code-action-float)

  # Use `[g` and `]g` to navigate diagnostics
  # Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
  if exists('g:loaded_ale')
    nmap <silent> [g <plug>(ale_previous_wrap)
    nmap <silent> ]g <plug>(ale_next_wrap)
    nmap <silent> <leader>ldf <Plug>(ale_first)
    nmap <silent> <leader>ldc <Plug>(ale_last)
  else
    nmap <silent> [g <plug>(lsp-previous-diagnostic)
    nmap <silent> ]g <plug>(lsp-next-diagnostic)
  endif

  # GoTo code navigation
  nmap <silent> lgd <plug>(lsp-definition)
  nmap <silent> lgy <plug>(lsp-type-definition)
  nmap <silent> lgi <plug>(lsp-implementation)
  nmap <silent> lgr <plug>(lsp-references)

  # Symbol renaming
  nmap <leader>lrn <plug>(lsp-rename)

  # Use K to show documentation in preview window
  nnoremap <silent> K <ScriptCmd>ShowDocumentation()<CR>
  nnoremap <silent> <leader>h <plug>(lsp-hover)
enddef

def ShowDocumentation()
  logger.Trace('Enter in: ' .. substitute(expand('<stack>'), '.*\(\.\.|\s\)', '', ''))
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'help ' .. expand('<cword>')
  else
    execute(':LspHover')
  endif
enddef

export def LspVsnipConfig()

  imap <expr> <C-j> vsnip#available(1) ? "<Plug>(vsnip-expand-or-jump)" : "\<C-j>"
  imap <expr> <C-k> vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)"      : "\<C-k>"
  # Expand
  imap <expr> <C-j>   vsnip#expandable()  ? "<Plug>(vsnip-expand)"         : "\<C-j>"
  smap <expr> <C-j>   vsnip#expandable()  ? "<Plug>(vsnip-expand)"         : "\<C-j>"

  # Expand or jump
  imap <expr> <C-l>   vsnip#available(1)  ? "<Plug>(vsnip-expand-or-jump)" : "\<C-l>"
  smap <expr> <C-l>   vsnip#available(1)  ? "<Plug>(vsnip-expand-or-jump)" : "\<C-l>"

enddef

def CheckBackspace(): bool
  var col = col('.') - 1
  return col == 0 || getline('.')[col - 1]  =~# '\s'
enddef

def HandleTab(): string
  if pumvisible() && (complete_info().selected == -1)
    if vsnip#available(1)
      return "\<Plug>(vsnip-expand-or-jump)"
    else
      return "\<C-n>"
    endif
  elseif pumvisible()
    return "\<C-n>"
  elseif vsnip#available(1)
    return "\<Plug>(vsnip-expand-or-jump)"
  else
    if CheckBackspace()
      return "\<Tab>"
    else
      return asyncomplete#force_refresh()
    endif
  endif
enddef

def HandleShiftTab(): string
  if pumvisible() && (complete_info().selected == -1)
    if vsnip#jumpable(-1)
      return "\<Plug>(vsnip-jump-prev)"
    else
      return "\<C-p>"
    endif
  elseif pumvisible()
    return "\<C-p>"
  elseif vsnip#jumpable(-1)
    return "\<Plug>(vsnip-jump-prev)"
  else
    return "\<S-Tab>"
  endif
enddef

def HandleEnter(): string
  if pumvisible() && (complete_info().selected == -1)
    if vsnip#available(1)
      return "\<Plug>(vsnip-expand-or-jump)"
    else
      return "\<CR>"
    endif
  elseif pumvisible()
    return "\<C-y>"
  elseif vsnip#available(1)
    return "\<Plug>(vsnip-expand-or-jump)"
  else
    return "\<CR>"
  endif
enddef
