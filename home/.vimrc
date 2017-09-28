" ----------- Quick Initialization --------------
" If vim-tiny or vim-small, skip lots of this
if !1 | finish | endif

" -------------- Basic settings -----------------
if has('vim_starting')
  let mapleader = "\<Space>"      " Custom commands mapped to space instead of \
  nnoremap <Space> <Nop>
  syntax on                       " Syntax highlighting
  set nocompatible                " Get rid of obsolete compatability mode
  set number                      " Line numbers
  set smartindent                 " Autoindent
  set breakindent                 " Make wrapped lines match line indent level
  set backspace=indent,eol,start  " Sane backspace
  set ls=2                        " Echo the file listing continuously
  set modelines=0                 " Abstain from executing modelines (security)
  set sm                          " Short messages
  set completeopt=longest,menuone " Longest common match & always show menu
  set wildmode=longest,list,full  " Better autocomplete
  set wildmenu                    " ^
  set scrolloff=3                 " Move window ahead of cursor
  set mouse=a                     " Mouse support
  set ruler                       " Show the ruler
  set hidden                      " Allow unsaved buffers to be backgrounded
  set showbreak=↪\                " Show line breaks
  set listchars=tab:▸\ ,eol:¬     "  ^   tabs and end of lines
  set list                        "  ^   them all
  set linebreak                   " Don't break words when wrapping
  set virtualedit=block           " Select visual blocks unbounded by end-of-line
  " set nobackup                    " Stop creating *~ files
  set cursorline                  " Highlight active line, x axis
  set cursorcolumn                " Highlight active line, y axis
  set display=lastline            " Don't hide long wrapped lines
  set nolazyredraw                " Workaround tmux+iTerm2 redraw issues
  set textwidth=79                " Wrap comments automatically
endif

" <Enter> in autocomplete selects, not newline
" Disabled for now because it conflicts with delimitMate
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Always highlight closest match
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" --------------- Tab Settings ------------------
" Remap tab-switching to Ctrl-T
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

" ------------ Searching settings ---------------
" Remap regex searching
nnoremap / /\v
vnoremap / /\v
set ignorecase      " Ignore case
set smartcase       " If caps exist, search them
set gdefault        " Default to global replace
set incsearch       " Settings to enable search as you type
set showmatch       " ^
set hlsearch        " ^

" --------------- Tabstop settings --------------
set tabstop=2               " Configure the tabstop to four spaces
set shiftwidth=2            " ^
set softtabstop=2           " ^
set expandtab               " ^

" ----------------- Commands --------------------
" Write buffer through sudo
cnoreabbrev w!! w !sudo tee % >/dev/null

" ------------------- Keymaps ------------------
" Stop reaching
inoremap fd <Esc>

" F1 = GUI paste, F2 = GUI copy
nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>
" F3 - Toggle 80 column marker
nnoremap <F3> :call ToggleColorColumn()<CR>
" F4 - Initiate Gundo
nnoremap <F4> :GundoToggle<CR>

" Bind tab to <C-w> to ease viewport switching
map <tab> <C-w>
map <tab><tab> <C-w><C-w>

" Enter insert mode surrounded by newlines
nnoremap <C-a> o<Esc>O<Esc>o
" Add newline and skip insert mode
nnoremap <C-o> O<Esc>

" Replace annoying Q behavior with more useful previous-end-of-word
nnoremap Q ge

" Traverse lines more intelligently
nnoremap j gj
nnoremap k gk
" Save old behavior
nnoremap gj j
nnoremap gk k

" Center searching
nnoremap n nzz
nnoremap } }zz

" yy already yanks a line - redefine Y to behave like D
nnoremap Y y$

" Buffer navigation shortcuts
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>

" ----------- Custom Leader Commands ------------
" These are basically lil baby macros.
" <leader>1 -  Quit without saving (think <leader>!)
nnoremap <leader>1 :qa!<CR>
" <leader>A - Align along equals
nnoremap <leader>A :Tabularize /=<CR>
" <leader>a - Align puppet code
nnoremap <leader>a :Tabularize /=><CR>
" <leader>c - Empty
" <leader>D - Delete /all/ buffers
nnoremap <leader>D :bufdo :Bdelete<CR>
" <leader>d - Delete current buffer without exiting
nnoremap <leader>d :Bdelete<CR>
" <leader>E - Execute current line, appending output
nnoremap <leader>E "=system(getline('.'))<CR>p`]
" <leader>e - Edit .vimrc
nnoremap <leader>e :e ~/.vimrc<CR>
" <leader>H - Hide hidden files
nnoremap <leader>H :let g:ctrlp_show_hidden=0<CR>:CtrlPClearCache<CR>
" <leader>h - Show hidden files
nnoremap <leader>h :let g:ctrlp_show_hidden=1<CR>:CtrlPClearCache<CR>
" <leader>i - Indent entire block
nnoremap <leader>i vv[m>%`>
" <leader>I - Indent empty-line delimited block
nnoremap <leader>I {v}>
" <leader>k - Scratch buffer
nnoremap <leader>k :Scratch<CR>
" <leader>M - Markdown preview
nnoremap <leader>M :InstantMarkdownPreview<CR>
" <leader>n - Open NERDtree
nnoremap <leader>n :NERDTree<CR>
" <leader>P - Toggle paste mode
set pastetoggle=<leader>P
" <leader>p - Paste from system clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
" <leader>q - Replace quotes
nnoremap <leader>q :.s/"\([^"]\+\)"/'\1'/<CR>:let @/=''<CR>
" <leader>r - Reload .vimrc
nnoremap <leader>r :so ~/.vimrc<CR>
" <leader>R - Toggle rainbow parenthsese
nnoremap <leader>R :RainbowToggle<CR>
" <leader>s - Search through files using ag
nnoremap <leader>s :Ag<space>
" <leader>S - Edit .ssh/known_hosts
nnoremap <leader>S :e ~/.ssh/known_hosts<CR>
" <leader>T - Globally replace tabs white four-space tabs
nnoremap <leader>T :%s/\t/    /e<CR>:let @/=''<CR>
" <leader>v - Fix interpolated puppet strings
nnoremap <leader>v :.s/\(".*\$\)\([a-zA-Z_]\+\)\(.*"\)/\1{\2}\3/<CR>:let @/=''<CR>
" <leader>W - Strip all trailing whitespace in the current file.
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" <leader>w - Shortcut to write file
nnoremap <leader>w :w<CR>
" <leader>x - Close quickfix/preview windows
nnoremap <leader>x :cclose<CR><C-w>z
" <leader>y - Yank into system clipboard
vnoremap <leader>y "+y
" <leader>z - Neomake (because all other shortcuts are taken?)
nnoremap <leader>z :Neomake<CR>

" Ctrl-P Shortcuts
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>m :CtrlPMRU<CR>
nnoremap <leader>l :CtrlPLine<CR>
nnoremap <leader>t :CtrlPTag<CR>

" Toggle search highlighting
nmap <silent> <leader>/ :set hlsearch!<cr>

nnoremap <silent> tw :GhcModTypeInsert<CR>
nnoremap <silent> ts :GhcModSplitFunCase<CR>
nnoremap <silent> tq :GhcModType<CR>
nnoremap <silent> te :GhcModTypeClear<CR>

" ----------------- vim-plug --------------------
" Required vim-plug prelude
call plug#begin('~/.local/share/nvim/plugged')

" Generic plugins
"
" - Surround with cs/ys
Plug 'tpope/vim-surround'
" - Lots of bracket matching movement
Plug 'tpope/vim-unimpaired'
" - Filesystem tree browsing
Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle'] }
" - Fuzzy matching for buffers/files/etc.
Plug 'kien/ctrlp.vim'
" - Auto-alignment for arbitrary delimiteres
Plug 'godlygeek/tabular', { 'on': 'Tab' }
" - Fast grepping
Plug 'rking/ag.vim'
" - <C--> commenting shortcuts
Plug 'tomtom/tcomment_vim'
" - Better buffer deletion
Plug 'moll/vim-bbye'
" - Auto-closing for quotes/parens/etc.
Plug 'Raimondi/delimitMate'
" - Somewhat okay git integration
Plug 'tpope/vim-fugitive'
" - Better scratch buffer
Plug 'mtth/scratch.vim'
" - Mercurial integration
Plug 'ludovicchabant/vim-lawrencium'
" - Better tags support
Plug 'ludovicchabant/vim-gutentags'
" - Syntax checking and linting
Plug 'neomake/neomake'
  Plug 'dojoteef/neomake-autolint'
" - Highlight parenthesis
Plug 'luochen1990/rainbow'
" - SLIME!
Plug 'jpalardy/vim-slime'
" - Better graphical undo
Plug 'sjl/gundo.vim'

" Language-specific support
"
" - Enhanced Haskell IDE
Plug 'myfreeweb/intero.nvim', { 'for': 'haskell' }
Plug 'dag/vim2hs', { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
  Plug 'Shougo/vimproc'
" - Self-explanatory language support bundles:
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'robbles/logstash.vim'
Plug 'jnwhiteh/vim-golang', { 'for': 'go' }
Plug 'rodjek/vim-puppet', { 'for': 'puppet' }
Plug 'raichoo/purescript-vim', { 'for': 'purescript' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'LnL7/vim-nix', { 'for': 'nix' }
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
Plug 'ElmCast/elm-vim', { 'for': 'elm' }

" SnipMate and dependencies
Plug 'MarcWeber/vim-addon-mw-utils' | Plug 'tomtom/tlib_vim' | Plug 'garbas/vim-snipmate'

" Bundle of snippets
Plug 'honza/vim-snippets'

" Theming
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Delete buffers in ctrlp
Plug 'd11wtq/ctrlp_bdelete.vim'

" Markdown (depends on tabular)
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
Plug 'rhysd/vim-gfm-syntax', { 'for': 'markdown' }

" - Shared editing
" Plug 'floobits/floobits-neovim'

" - Highlight a visual range with a specific syntax
Plug 'vim-scripts/ingo-library' | Plug 'vim-scripts/SyntaxRange'

call plug#end()
filetype plugin indent on " Required

" ------------ Language Settings ----------------

" Wrap in an autocommand group to avoid this problem:
" http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
augroup custom_filetypes
  autocmd!

  " The dag/vim2hs bundle has /awful/ auto-folding behavior
  " We also want to use hindent for good formatting
  autocmd FileType haskell setlocal nofoldenable formatprg=hindent

  " Format golang files the canonical way
  autocmd BufNew,BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

  " Correctly detect markdown files
  autocmd FileType markdown setlocal spell

  " Correctly render erb files
  autocmd BufNew,BufNewFile,BufRead *.sh.erb setlocal ft=sh.eruby
  autocmd BufNew,BufNewFile,BufRead *.py.erb setlocal ft=eruby.python

  " I use a gitrc
  autocmd BufNew,BufNewFile,BufRead .gitrc setlocal ft=gitconfig

  " Correctly detect Vagrantfiles
  autocmd BufNew,BufNewFile,BufRead Vagrantfile setlocal ft=ruby sts=2 sw=2

  " .path files are systemd units
  autocmd BufNew,BufNewFile,BufRead *.path setlocal ft=systemd

  " Non-standard shell scripts
  autocmd BufNew,BufNewFile,BufRead PKGBUILD,.envrc setlocal filetype=sh

augroup END

" ----------------- Theming ---------------------
let g:jellybeans_overrides = {
\    'Directory': { 'guifg': '597bc5',
\              'ctermfg': 'Blue', 'ctermbg': 'Black',
\              'attr': 'bold' },
\}

" set t_Co=256                      " Fix color depth
" let g:solarized_termtrans = 1     " Fix glyph backgrounds
" set background=dark               " Use dark background
colorscheme jellybeans              " From homeshick
hi SpecialKey ctermbg=None        " Smooth out colors, jeez
set guifont=Source\ Code\ Pro:h15 " Non-standard but better font
" let g:rehash256 = 1
let g:airline_theme = 'jellybeans'

" Make vertsplits cleaner
highlight VertSplit ctermbg=236 ctermfg=236
set fillchars+=vert:\ 

" ----------- CTRLP Buffer Deletion -------------
call ctrlp_bdelete#init()

" ---------------- Plugin Settings ---------------

" Quick execution output into a scratch buffer
nnoremap <C-c> V:ScratchSelection!<CR>"=system(getline('.'))<CR>p<C-w>p
" I usually keep scratch open
let g:scratch_autohide=0
" Pop-open at bottom
let g:scratch_top=0

" delimitMate settings
let delimitMate_expand_cr=1
let delimitMate_expand_space=1

" Enable omnicomplete
set omnifunc=syntaxcomplete#Complete

" ctags
" Let colons work for tags
set iskeyword=-,:,@,48-57,_,192-255

" netrw

" Supporting function: toggle netrw window
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction

" A better shell executor: open stdout in a scratch buffer
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

" Make netrw behave more as a file browser
let g:netrw_browse_split = 4 " Open new files in a vertical split
let g:netrw_altv = 1         " ^
let g:netrw_liststyle = 3    " Default to tree view
let g:netrw_banner = 0       " Default to tree view

" CtrlP line search extension
let g:ctrlp_extenions = ['line']
" Smart directory searching behavior in Ctrl-P:
" 'c' - the directory of the current file.
" 'r' - the nearest ancestor that contains one of these directories or files:
"       .git .hg .svn .bzr
" 'a' - like c, but only if the current working directory outside of CtrlP is
"       not a direct ancestor of the directory of the current file.
" 0 or '' (empty string) - disable this feature.
let g:ctrlp_working_path_mode = 'ra'
" Change to 'search' mnemonic, I use C-p for previous buffer
" (note: this doesn't work because it's a terminal signal, I use <leader>f
" for ctrl-p anyway)
let g:ctrlp_map = '<C-s>'
" Retrieve file list from git, if possible
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1

" Change CWD when NERDTree changes root
let g:NERDTreeChDirMode=2
" Smaller default window size
let g:NERDTreeWinSize=20

" Close NERDTree if it's the last window open
augroup nerdtree_close
  autocmd!

  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
" mnemonic - eXplore
map <silent> <C-x> :call ToggleVExplorer()<CR>

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" Default to tree mode
let g:netrw_liststyle=3

" Haskell Plugin Settings
" Stop stupid '.' conceals
let g:haskell_conceal = 0
let g:haskell_conceal_enumerations = 0

" Markdown plugin settings
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_disabled = 1

" Disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
if &term =~ '256color'
  set t_ut=
endif

" Disable automatic live markdown previews
let g:instant_markdown_autostart = 0

" Stop elm-vim from hijacking leader shortcuts
let g:elm_setup_keybindings = 0

" Automatically format terraform files
let g:terraform_fmt_on_save = 1

" Use a hidden tag file
let g:gutentags_ctags_tagfile = ".tags"

" Neomake
let g:neomake_autolint_sign_column_always = 1

" Rainbow parentheses
let g:rainbow_active = 1

" SLIME
let g:slime_target = "tmux"

" --------------- Custom functions ---------------

func! ToggleColorColumn()
  if exists("b:colorcolumnon") && b:colorcolumnon
    let b:colorcolumnon = 0
    exec ':set colorcolumn=0'
    echo '80 column marker off'
  else
    let b:colorcolumnon = 1
    exec ':set colorcolumn=80'
    echo '80 column marker on'
  endif
endfunc

" Load the builtin matchit macro (for things like ruby block %-ing)
runtime macros/matchit.vim
