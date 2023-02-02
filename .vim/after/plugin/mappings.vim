vim9script

if exists("g:loaded_mapping_plugin")
  finish
endif

g:loaded_mapping_plugin = 1

# Basic {{{1

# Normal Mode
# Allows the cursor to move up and down naturally by display, lines instead of file lines:{{{
nnoremap j gj
nnoremap k gk
# Make yanking with capital Y behave like the other capital letters, and yank until the end of the line:{{{
nnoremap Y y$

# Insert Mode
# Spell correction
inoremap <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u
# In insert or command mode, move normally by using Ctrl {{{
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
# Bash like
inoremap <C-a> <Home>
inoremap <expr><C-e> pumvisible() ? "\<C-e>" : "\<End>"
inoremap <C-d> <Delete>
inoremap <C-w> <C-[>diwa
inoremap <C-u> <C-G>u<C-U>

# Command mode shortcut
cnoremap w!! w !sudo tee % >/dev/null
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>
cnoremap <C-b> <S-Left>
cnoremap <C-f> <S-Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Delete>
cnoremap <C-t> <C-R>=expand("%:p:h") . "/" <CR>
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
#}}}

# Leader {{{1
# Press your 'leader' key + enter to toggle search highlighting:{{{
nnoremap <leader><CR> :set hlsearch! hlsearch?<CR>
#}}}

# LocalLeader {{{1
#}}}


