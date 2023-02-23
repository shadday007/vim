vim9script

if exists('g:loaded_options_plugin')
  finish
endif

g:loaded_options_plugin = 1

# Indention Options {{{1
filetype indent plugin on
set backspace=indent,eol,start # Makes the backspace key behave like you'd expect
set autoindent
set smartindent
set breakindent
set linebreak
set tabstop=2           # 2 space tab
set expandtab           # use spaces for tabs
set softtabstop=2       # 2 space tab
set shiftwidth=2
set modeline
set modelines=1
# }}}

# Search Options {{{1
set ignorecase          # ignore case when searching
set incsearch           # search as characters are entered
set hlsearch            # highlight all matches
set smartcase           # ignores case unless an upper case letter is present in the query
# }}}

# Performance Options {{{1
# }}}

# Text Rendering Options {{{1
syntax enable
set showbreak=↪  # ↳ ↪
set list
set listchars=
set listchars+=tab:░\
set listchars+=trail:·
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:⣿
# }}}

# User Interface Options {{{1
set termguicolors
if has('gui')
    set guioptions-=m  #remove menu bar
    set guioptions-=T  #remove toolbar
    set guioptions-=r  #remove right-hand scroll bar
    set guioptions-=L  #remove left-hand scroll bar when there is a vertically split window
    set guioptions-=R  #remove Right-hand scrollbar is present when there is a vertically
    set guioptions-=b  #remove Bottom (horizontal) scrollbar
    set guioptions-=l  #remove Left-hand scrollbar
endif
set wildmenu
set wildmode=longest,full
set wildoptions=fuzzy,pum,tagfile
set wildignore=*~,#*#,*.7z,.DS_Store,.git,.hg,.svn,*.a,*.adf,*.asc,*.au,*.aup
            \,*.avi,*.bin,*.bmp,*.bz2,*.class,*.db,*.dbm,*.djvu,*.docx,*.exe
            \,*.filepart,*.flac,*.gd2,*.gif,*.gifv,*.gmo,*.gpg,*.gz,*.hdf,*.ico
            \,*.iso,*.jar,*.jpeg,*.jpg,*.m4a,*.mid,*.mp3,*.mp4,*.o,*.odp,*.ods,*.odt
            \,*.ogg,*.ogv,*.opus,*.pbm,*.pdf,*.png,*.ppt,*.psd,*.pyc,*.rar,*.rm
            \,*.s3m,*.sdbm,*.sqlite,*.swf,*.swp,*.tar,*.tga,*.ttf,*.wav,*.webm,*.xbm
            \,*.xcf,*.xls,*.xlsx,*.xpm,*.xz,*.zip,.cache,.local,spell
set mouse=a            # Enable mouse drag on window splits
set mousemodel=popup
set scrolloff=10       # Allows try to show 10 lines above and below the cursor location
set number             # show line numbers
set relativenumber
set shortmess+=catOI   # use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set showcmd            # show command in bottom bar
set wildignorecase     # Case insensitive in command-line mode
set laststatus=2       # show always stausline
set cmdheight=1        # Height of the command bar
set cursorline         # highlight current line
set lazyredraw
set showmatch          # higlight matching parenthesis
set fillchars+=vert:┃
set diffopt=filler,vertical
set updatetime=100
set splitbelow         # Always split below
set splitright         # Always split right
set colorcolumn=85
set signcolumn=number  # signs replace line numbers
# By default timeoutlen is 1000 ms
set timeoutlen=500
# }}}

# Code Folding Options {{{1
if has('folding')
    if has('windows')
        set fillchars=diff:∙               # BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
        set fillchars+=fold:·              # MIDDLE DOT (U+00B7, UTF-8: C2 B7)
        set fillchars+=vert:┃              # BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
    endif

    set foldmethod=marker               # not as cool as syntax, but faster
    set foldlevel=256                   # start unfolded
    set foldlevelstart=1                # start with fold level of 1
    set foldnestmax=10                  # max 10 depth for the 'indent' and 'syntax' methods
    set nofoldenable                    # don't fold files by default on open
    set foldcolumn=0                    # show a small column on the left side of the window
endif
# }}}


# Directories Options {{{2
if exists('$SUDO_USER')
    set nobackup                        # don't create root-owned files
    set nowritebackup                   # don't create root-owned files
    set noswapfile                      # don't create root-owned files
    set noundofile                      # don't create root-owned files
else
    set backupdir=$HOME/.cache/vim/backup  | call mkdir(&backupdir, 'p', 0700)   # keep backup files out of the way
    set backupdir+=.
    set directory=$HOME/.cache/vim/swap  | call mkdir(&directory, 'p', 0700)     # keep swap files out of the way
    set directory+=.
    set undodir=$HOME/.cache/vim/undo | call mkdir(&undodir, 'p', 0700)   # keep undo files out of the way
    set undodir+=.
    set undofile                      # actually use undo files
    set undolevels=1000      # Maximum number of changes that can be undone
    set undoreload=10000     # Maximum number lines to save for undo on a buffer reload
endif

if has('mksession')
    # override ~/.vim/view default
    set viewdir=$HOME/.cache/vim/view | call mkdir(&viewdir, 'p', 0700)
    set viewoptions=cursor,folds        # save/restore just these (with `:{mk,load}view`)
endif
#}}}

# Spell configuration {{{1
set spelllang=en_us
set spellcapcheck=[.?!]\\%(\ \ \\\|[\\n\\r\\t]\\)
if exists('+spelloptions')
    set spelloptions+=camel
endif
set dictionary^=/usr/share/dict/usa
set dictionary+=/usr/share/dict/spanish
set thesaurus^=$HOME."/.vim/spell/thesaurus.txt"  #<https://sanctum.geek.nz/ref/thesaurus.txt>
set complete+=kspell
set completeopt=menuone,longest,popup
set spellsuggest=double
#}}}

# Format options {{{1
set formatoptions+=l
set formatoptions+=1
if has('patch-7.3.541')
    set formatoptions+=j
endif
set cpoptions+=J
if has('patch-8.1.728')
    set formatoptions+=p
endif
#}}}

# Miscellaneous Options {{{1
set hidden # Allows you to switch between buffers without saving EVERY TIME
set history=10000
# }}}
