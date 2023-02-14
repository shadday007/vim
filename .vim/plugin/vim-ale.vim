let g:ale_fix_on_save = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_completion_autoimport = 1
let g:ale_completion_enabled = 1

let g:ale_sign_error = '✖'
let g:ale_sign_warning = '➤'
let g:ale_sign_info = "ⓘ"
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = "🔥 "

let g:ale_set_quickfix = 1

let g:ale_linters = {
      \ 'c': ['clang'],
      \ 'cpp': ['clang'],
      \ 'go': ['gopls', 'gofmt'],
      \ 'h': ['clang'],
      \ 'javascript': ['eslint'],
      \ 'python': ['pylint', 'flake8'],
      \ 'typescript': ['prettier'],
      \ 'ruby': ['standardrb', 'rubocop'],
      \ 'rust': ['rustfmt'],
      \ 'vue': ['eslint', 'stylelint', 'vls'],
      \ 'vuejs': ['eslint', 'stylelint', 'vls'],
      \ 'svelte': ['eslint'],
      \ }

let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'c': ['clang-format'],
      \ 'cpp': ['clang-format'],
      \ 'go': ['gofmt', 'goimports'],
      \ 'h': ['clang-format'],
      \ 'javascript': ['prettier', 'eslint'],
      \ 'python': ['black'],
      \ 'typescript': ['prettier', 'eslint', 'tslint'],
      \ 'ruby': ['rubocop'],
      \ 'rust': ['rustfmt'],
      \ 'vue': ['prettier'],
      \ 'vuejs': ['prettier'],
      \ 'svelte': ['prettier'],
      \ }

if isdirectory('/usr/local/llvm12')
  let g:ale_c_clangd_executable = '/usr/local/bin/clang-format12'
  let g:ale_c_clangformat_executable = '/usr/local/bin/clang-format12'
endif
