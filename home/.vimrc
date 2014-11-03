" -------------- Basic settings -----------------
set nocompatible                " Get rid of obsolete compatability mode
set nu                          " Line numbers
set ai                          " Autoindent
set backspace=indent,eol,start  " Sane backspace
set ls=2                        " Echo the file listing continuously
nnoremap <tab> %                " Remap % to tab, easier bracket matching
vnoremap <tab> %                " ^
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
inoremap jk <Esc>               " Stop reaching for Esc

" Correctly detect markdown files
autocmd BufNew,BufNewFile,BufRead *.txt,*.text,*.md,*.markdown setlocal ft=markdown

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
" F1 = GUI paste, F2 = GUI copy
nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>
" Bind tab to <C-w> to ease viewport switching
map <tab> <C-w>
map <tab><tab> <C-w><C-w>
" Enter insert mode surrounded by newlines
nmap <C-a> o<Esc>O
" Replace annoying Q behavior with more useful previous-end-of-word
nnoremap Q ge

" ----------- Custom Leader Commands ------------
" These are basically lil baby macros.
" ,W - Strip all trailing whitespace in the current file.
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" ,w - Switch to a split view and use it
nnoremap <leader>w <C-w>v<C-w>l
" ,v - Fix interpolated puppet strings
nnoremap <leader>v :.s/\(".*\$\)\([a-zA-Z_]\+\)\(.*"\)/\1{\2}\3/<CR>:let @/=''<CR>
" ,T - Globally replace tabs white four-space tabs
nnoremap <leader>T :%s/\t/    /e<CR>:let @/=''<CR>
" ,a - Align puppet code
nnoremap <leader>a :Tab /=><CR>
" ,q - Replace quotes
nnoremap <leader>q :.s/"\([^"]\+\)"/'\1'/<CR>:let @/=''<CR>
" ,d - Delete current buffer without exiting
nnoremap <leader>d :Bdelete<CR>
" ,D - Delete /all/ buffers
nnoremap <leader>D :bufdo :Bdelete<CR>
" ,P - Toggle paste mode
set pastetoggle=<leader>P
" ,i - Indent entire block
nnoremap <leader>i vv[m>%`>
" ,c - Invoke a manual syntax check
nnoremap <leader>c :SyntasticCheck<CR>
" ,h - Show hidden files
nnoremap <leader>h :let g:ctrlp_show_hidden=1<CR>:CtrlPClearCache<CR>
" ,H - Hide hidden files
nnoremap <leader>H :let g:ctrlp_show_hidden=0<CR>:CtrlPClearCache<CR>
" ,x - Close quickfix/preview windows
nnoremap <leader>x :cclose<CR><C-w>z
" ,s - Search files using ack
nnoremap <leader>s :Ag<space>
" ,p - Paste from system clipboard
inoremap <leader>p <ESC>"+p
nnoremap <leader>p "+p
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

" ------------------ Vundle ---------------------
filetype off                   " Required
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Generic bundles
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'godlygeek/tabular'
Bundle 'rking/ag.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'moll/vim-bbye'

" Easytags and deps
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-easytags'

" Language-specific support
Bundle 'scrooloose/syntastic'
Bundle 'jnwhiteh/vim-golang'
Bundle 'rodjek/vim-puppet'

" SnipMate and dependencies
Bundle "garbas/vim-snipmate"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
" Bundle of snippets
Bundle "honza/vim-snippets"

" Theming
Bundle 'nanotech/jellybeans.vim'
Bundle 'bling/vim-airline'

" Delete buffers in ctrlp
Bundle 'd11wtq/ctrlp_bdelete.vim'

" To handle git and hg repos, respectively
Bundle 'tpope/vim-fugitive'
Bundle 'ludovicchabant/vim-lawrencium'

" Saving just in case.
" Bundle 'chriskempson/base16-vim'
" Bundle 'Pychimp/vim-luna'
" Bundle 'tomasr/molokai'
" Bundle 'sickill/vim-monokai'
" Bundle 'altercation/vim-colors-solarized'

filetype plugin indent on         " Required

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

" Make netrw behave more as a file browser
let g:netrw_browse_split = 4 " Open new files in a vertical split
let g:netrw_altv = 1         " ^
let g:netrw_liststyle = 3    " Default to tree view
let g:netrw_banner = 0       " Default to tree view

" CtrlP line search extension
let g:ctrlp_extenions = ['line']

" Custom syntastic flags
let g:syntastic_puppet_puppetlint_args="--no-class_inherits_from_params_class-check"
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
map <silent> <C-E> :call ToggleVExplorer()<CR>

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" Default to tree mode
let g:netrw_liststyle=3

" Turn on asynchronous ctag writing
let g:easytags_async=1

" Change directory to the current buffer when opening files.
set autochdir
