" David Amirault

" ================
" General Settings
" ================

" visual
set background=dark
set guicursor+=a:blinkon100
set relativenumber

" wrap
set wrap
set linebreak
set whichwrap+=<,>,[,],h,l

" tab
set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab

" search
set ignorecase
set smartcase

" paste
set pastetoggle=<F2>

" buffers
set hidden

" ====================
" Plugin Configuration
" ====================

" default directories
let g:backupdir=stdpath('data').'/backup'
if !isdirectory(g:backupdir)
    execute 'silent !mkdir -p '.g:backupdir
endif
let &backupdir=g:backupdir
let g:netrw_home=stdpath('data').'/netrw'

" plugin initialization
let g:plugged=stdpath('data').'/plugged'
if !isdirectory(g:plugged)
    execute 'silent !mkdir -p '.g:plugged
    let g:autoload=stdpath('data').'/site/autoload/plug.vim'
    let g:url='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    execute 'silent !curl -fLo '.g:autoload.' --create-dirs '.g:url
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"plugins
call plug#begin(g:plugged)
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
call plug#end()

" ================
" Display Settings
" ================

" eye candy
let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:netrw_fastbrowse=0
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
colorscheme solarized

" display fixes
match LineNr /\s\+$/
autocmd bufenter * highlight CursorLineNr ctermfg=10 ctermbg=0
autocmd bufenter * set visualbell t_vb=
autocmd VimLeave * set guicursor=a:ver25

" ========
" Commands
" ========

" filetype fixes
autocmd FileType netrw setlocal bufhidden=wipe
autocmd FileType html,xhtml setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType make setlocal noexpandtab
autocmd FileType c,cpp setlocal commentstring=//\ %s

" software update
command! PU PlugUpdate | PlugUpgrade

" ========
" Mappings
" ========

" leader
let mapleader=","
noremap , <Nop>

" navigation
noremap <Leader>t zt
noremap <Leader>b zb
noremap <Leader><Leader> zz
noremap <Leader>h <C-w>h
noremap <Leader>j <C-w>j
noremap <Leader>k <C-w>k
noremap <Leader>l <C-w>l

" convenience mappings
noremap <Space> :
noremap : ,
inoremap {} {<CR>}<Esc>O
nnoremap Y y$
nnoremap <silent> <CR> :nohlsearch<CR>

" escape
tnoremap tn <C-\><C-n>
vnoremap tn <Esc>
inoremap tn <Esc>

" fuzzy find
nnoremap <silent> <Leader>p :GFiles<CR>
