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
set paste                       " Not-stupid pasting
set ruler                       " Show the ruler
set hidden                      " Allow unsaved buffers to be backgrounded

" ----------------- Theming ---------------------
let g:solarized_termtrans = 1   " Enable a good colorscheme
colorscheme solarized           " Non-default colorscheme
set background=dark             " Use dark background
hi SpecialKey ctermbg=8         " Smooth out colors, jeez
set guifont=Source\ Code\ Pro:h15 " Non-standard but better font

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
set list                    " Set invisible chars to display
set listchars=tab:▸\ ,eol:¬ " ^

" ------------------ Clipboard ------------------
" F1 = GUI paste, F2 = GUI copy
nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>

" ----------- Custom Leader Commands ------------
" These are basically lil baby macros.
" ,W - Strip all trailing whitespace in the current file.
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" ,w - Switch to a split view and use it
nnoremap <leader>w <C-w>v<C-w>l
" ,v - Fix interpolated puppet strings
nnoremap <leader>v :.s/\(".*\$\)\([a-zA-Z_]\+\)\(.*"\)/\1{\2}\3/<CR>:let @/=''<CR>
" ,t - Globally replace tabs white four-space tabs
nnoremap <leader>t :%s/\t/    /e<CR>:let @/=''<CR>
" ,T - Tabularize puppet code
nnoremap <leader>T :Tab /=><CR>
" ,q - Replace quotes
nnoremap <leader>q :.s/"\([^"]\+\)"/'\1'/<CR>:let @/=''<CR>
" ,d - Delete current buffer without exiting
nnoremap <leader>d :bp<bar>sp<bar>bn<bar>bd<CR>

" Ctrl-P Shortcuts
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>m :CtrlPMRU<CR>
nnoremap <leader>l :CtrlPLine<CR>

" NERDtree shortcut
nnoremap <leader>n :NERDTree<CR>

" ------------------ Vundle ---------------------
filetype off                   " Required
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'rodjek/vim-puppet'
Bundle 'godlygeek/tabular'

filetype plugin indent on      " Required

" ----------- CTRLP Buffer Deletion -------------
let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }

func! MyCtrlPMappings()
    nnoremap <buffer> <silent> <c-@> :call <sid>DeleteBuffer()<cr>
endfunc

func! s:DeleteBuffer()
    exec "bd" fnamemodify(getline('.')[2:], ':p')
    exec "norm \<F5>"
endfunc

" CtrlP line search extension
let g:ctrlp_extenions = ['line']

" ------------ NERDTree things ----------------------

" Close NERDTree if it's the last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

