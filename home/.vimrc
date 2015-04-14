" ----------- Quick Initialization --------------
" If vim-tiny or vim-small, skip lots of this
if !1 | finish | endif

" -------------- Basic settings -----------------
if has('vim_starting')
    set nocompatible                " Get rid of obsolete compatability mode
    set number                      " Line numbers
    set smartindent                 " Autoindent
    set backspace=indent,eol,start  " Sane backspace
    set ls=2                        " Echo the file listing continuously
    " nnoremap <tab> %                " Remap % to tab, easier bracket matching
    " vnoremap <tab> %                " ^
    set modelines=0                 " Security-related setting, so I hear
    let mapleader = ","             " Custom commands mapped to , instead of \
    syntax on                       " Syntax highlighting
    set sm                          " Short messages
    set completeopt=longest,menuone " Longest common match & always show menu
    set wildmode=longest,list,full  " Better autocomplete
    set wildmenu                    " ^
    set scrolloff=5                 " Move window ahead of cursor
    set mouse=a                     " Mouse support
    set ruler                       " Show the ruler
    set hidden                      " Allow unsaved buffers to be backgrounded
    set showbreak=↪\                 " Show line breaks
    set listchars=tab:▸\ ,eol:¬     "  ^   tabs and end of lines
    set list                        "  ^   them all
    set tags=./.tags;,~/.vimtags    " Prefer localized tags, then global
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
set tabstop=4               " Configure the tabstop to four spaces
set shiftwidth=4            " ^
set softtabstop=4           " ^
set expandtab               " ^

" ----------------- Commands --------------------
" Write buffer through sudo
cnoreabbrev w!! w !sudo tee % >/dev/null

" ------------------- Keymaps ------------------
" Disable arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Train to stop reaching for escape (avoid trailing comment, it's weird)
inoremap jk <Esc>

" F1 = GUI paste, F2 = GUI copy
nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>
" F3 - Toggle 80 column marker
nnoremap <F3> :call ToggleColorColumn()<CR>

" Bind tab to <C-w> to ease viewport switching
map <tab> <C-w>
map <tab><tab> <C-w><C-w>

" Enter insert mode surrounded by newlines
nmap <C-a> o<Esc>O<Esc>o

" Replace annoying Q behavior with more useful previous-end-of-word
nnoremap Q ge

" Traverse lines more intelligently
nnoremap j gj
nnoremap k gk

" Buffer navigation shortcuts
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>

" ----------- Custom Leader Commands ------------
" These are basically lil baby macros.
" ,a - Align puppet code
nnoremap <leader>a :Tab /=><CR>
" ,c - Invoke a manual syntax check
nnoremap <leader>c :SyntasticCheck<CR>
" ,D - Delete /all/ buffers
nnoremap <leader>D :bufdo :Bdelete<CR>
" ,d - Delete current buffer without exiting
nnoremap <leader>d :Bdelete<CR>
" ,e - Edit .vimrc
nnoremap <leader>e :e ~/.vimrc<CR>
" ,H - Hide hidden files
nnoremap <leader>H :let g:ctrlp_show_hidden=0<CR>:CtrlPClearCache<CR>
" ,h - Show hidden files
nnoremap <leader>h :let g:ctrlp_show_hidden=1<CR>:CtrlPClearCache<CR>
" ,i - Indent entire block
nnoremap <leader>i vv[m>%`>
" ,k - Scratch buffer
nnoremap <leader>k :Scratch<CR>
" ,l - <RESERVED> For Ctrl-P LRU files
" ,P - Toggle paste mode
set pastetoggle=<leader>P
" ,p - Paste from system clipboard
inoremap <leader>p <ESC>"+p
nnoremap <leader>p "+p
" ,q - Replace quotes
nnoremap <leader>q :.s/"\([^"]\+\)"/'\1'/<CR>:let @/=''<CR>
" ,r - Reload .vimrc
nnoremap <leader>r :so ~/.vimrc<CR>
" ,s - Search through files using ag
nnoremap <leader>s :Ag<space>
" ,T - Globally replace tabs white four-space tabs
nnoremap <leader>T :%s/\t/    /e<CR>:let @/=''<CR>
" ,v - Fix interpolated puppet strings
nnoremap <leader>v :.s/\(".*\$\)\([a-zA-Z_]\+\)\(.*"\)/\1{\2}\3/<CR>:let @/=''<CR>
" ,W - Strip all trailing whitespace in the current file.
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" ,w - Switch to a split view and use it
nnoremap <leader>w <C-w>v<C-w>l
" ,x - Close quickfix/preview windows
nnoremap <leader>x :cclose<CR><C-w>z
" ,y - Yank into system clipboard
vnoremap <leader>y "+y

" Ctrl-P Shortcuts
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>m :CtrlPMRU<CR>
nnoremap <leader>l :CtrlPLine<CR>
nnoremap <leader>t :CtrlPTag<CR>

" NERDtree shortcut
nnoremap <leader>n :NERDTree<CR>

" Toggle search highlighting
nmap <silent> <leader>/ :set hlsearch!<cr>

" ----------------- NeoBundle --------------------
" Bundles indented to signify dependencies

" Required NeoBundle prelude
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))

" Manage NeoBundle itself, and use vimproc to handle operations
NeoBundleFetch 'Shuogo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

" Generic bundles
" NeoBundle 'gmarik/vundle'
NeoBundle 'tpope/vim-surround'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'godlygeek/tabular'
NeoBundle 'rking/ag.vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'moll/vim-bbye'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mtth/scratch.vim'
NeoBundle 'ludovicchabant/vim-lawrencium'
NeoBundle 'xolox/vim-easytags'
    NeoBundle 'xolox/vim-misc'

" Language-specific support
" Bundle 'raichoo/haskell-vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'jnwhiteh/vim-golang'
NeoBundle 'rodjek/vim-puppet'
NeoBundle 'dag/vim2hs'
NeoBundle 'eagletmt/ghcmod-vim'
    " NeoBundle 'Shougo/vimproc'

" SnipMate and dependencies
NeoBundle "garbas/vim-snipmate"
    NeoBundle "MarcWeber/vim-addon-mw-utils"
    NeoBundle "tomtom/tlib_vim"
" Bundle of snippets
NeoBundle "honza/vim-snippets"

" Theming
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'bling/vim-airline'

" Delete buffers in ctrlp
NeoBundle 'd11wtq/ctrlp_bdelete.vim'

" Saving just in case.
" Bundle 'chriskempson/base16-vim'
" Bundle 'Pychimp/vim-luna'
" Bundle 'tomasr/molokai'
" Bundle 'sickill/vim-monokai'
" Bundle 'altercation/vim-colors-solarized'

call neobundle#end()
filetype plugin indent on         " Required
NeoBundleCheck

" ------------ Language Settings ----------------

" The dag/vim2hs bundle has /awful/ auto-folding behavior
autocmd FileType haskell setlocal nofoldenable
"
" Format golang files the canonical way
autocmd BufNew,BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

" Correctly detect markdown files
autocmd BufNew,BufNewFile,BufRead *.txt,*.text,*.md,*.markdown setfiletype markdown

" Correctly render erb files
autocmd BufNew,BufNewFile,BufRead *.sh.erb setlocal ft=sh.eruby

" I use a gitrc
autocmd BufNew,BufNewFile,BufRead .gitrc setlocal ft=gitconfig

" ----------------- Theming ---------------------
let g:jellybeans_overrides = {
\    'Directory': { 'guifg': '597bc5',
\              'ctermfg': 'Blue', 'ctermbg': 'Black',
\              'attr': 'bold' },
\}

" set t_Co=256                      " Fix color depth
" let g:solarized_termtrans = 1     " Fix glyph backgrounds
" set background=dark               " Use dark background
colorscheme jellybeans                  " From vundle
hi SpecialKey ctermbg=None        " Smooth out colors, jeez
set guifont=Source\ Code\ Pro:h15 " Non-standard but better font
" let g:rehash256 = 1
" let g:airline_theme = 'luna'

" Make vertsplits cleaner
highlight VertSplit ctermbg=236 ctermfg=236
set fillchars+=vert:\ 

" ----------- CTRLP Buffer Deletion -------------
call ctrlp_bdelete#init()

" ---------------- Plugin Settings ---------------

" delimitMate settings
let delimitMate_expand_cr=1
" let delimitMate_expand_space=1

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

" Custom syntastic flags
let g:syntastic_puppet_puppetlint_args="--no-class_inherits_from_params_class-check"
let g:syntastic_puppet_puppet_post_args="--parser future"
" Fancy symbols
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
" Lord it is slow
let g:syntastic_mode_map = { "mode": "passive", "active_filetypes": [], "passive_filetypes": [] }

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1

" Change CWD when NERDTree changes root
let g:NERDTreeChDirMode=2

" Close NERDTree if it's the last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


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
" mnemonic - browse
map <silent> <C-b> :call ToggleVExplorer()<CR>

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" Default to tree mode
let g:netrw_liststyle=3

" Turn on asynchronous ctag writing
let g:easytags_async=1

" Haskell Plugin Settings
" Stop stupid '.' conceals
let g:haskell_conceal = 0
let g:haskell_conceal_enumerations = 0

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
