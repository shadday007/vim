vim9script

if exists("g:loaded_mappings_plugin")
  finish
endif
g:loaded_mappings_plugin = 1

# Basic {{{1

# Normal Mode
# Allows the cursor to move up and down naturally by display, lines instead of file lines:{{{
nnoremap j gj
nnoremap k gk
# Make yanking with capital Y behave like the other capital letters, and yank until the end of the line:{{{
nnoremap Y y$
# To quickly resize windows
map - <C-W>-
map + <C-W>+
# Nicer Navigation
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l
# Maps shift-[arrows] to resizing a window split
nmap <silent> <S-LEFT> <C-w><
nmap <silent> <S-DOWN> <C-W>-
nmap <silent> <S-UP> <C-W>+
nmap <silent> <S-RIGHT> <C-w>>
# lists all loaded buffers and populates the prompt for you
nnoremap gb :ls<CR>:b<Space>

# Insert Mode
# Spell correction
inoremap <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u
# In insert or command mode, move normally by using Ctrl {{{
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
# Bash like
inoremap <C-a> <C-O>^
inoremap <C-X><C-A> <C-A>
inoremap <expr> <C-B> getline('.')=~'^\s*$'&&col('.') > strlen(getline('.')) ? "0\<Lt>C-D>\<Lt>Esc>kJs" : "\<Lt>Left>"
inoremap <expr><C-e> pumvisible() ? "\<C-e>" : "\<End>"
inoremap <expr> <C-D> col('.') > strlen(getline('.')) ? "\<Lt>C-D>" : "\<Lt>Del>"
inoremap <expr> <C-E> col('.') > strlen(getline('.'))<bar><bar>pumvisible() ? "\<Lt>C-E>" : "\<Lt>End>"
inoremap <expr> <C-F> col('.') > strlen(getline('.')) ? "\<Lt>C-F>" : "\<Lt>Right>"
inoremap <C-w> <C-[>diwa
inoremap <C-u> <C-G>u<C-U>

# Command mode shortcut
cnoremap <C-a> <Home>
cnoremap <C-X><C-A> <C-A>
cnoremap <C-b> <S-Left>
cnoremap <expr> <C-D> getcmdpos() > strlen(getcmdline()) ? "\<Lt>C-D>" : "\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos() > strlen(getcmdline()) ? &cedit : "\<Lt>S-Right>"
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <expr> <C-l> getcmdpos() > strlen(getcmdline()) ? "\<Lt>C-l>" : "\<Lt>Right>"
cnoremap <C-t> <C-R>=expand("%:p:h") . "/" <CR>
cnoremap w!! w !sudo tee % >/dev/null
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

# Visual Mode
# Move visual selection up and down a line
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
# Quickly re-select either the last pasted or changed text
noremap gV `[v`]
# Make dot work on visual line selections
xnoremap . :norm.<CR>
xnoremap < <gv
xnoremap > >gv
# no overwrite paste
xnoremap p "_dP
#}}}

# Leader {{{1
# Press your 'leader' key + enter to toggle search highlighting:{{{
nnoremap <leader><CR> :set hlsearch! hlsearch?<CR>
#}}}

# LocalLeader {{{1
#}}}


