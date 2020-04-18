" David Amirault

" general settings
set clipboard=unnamedplus
set pastetoggle=<F2>
set guicursor=a:blinkon100
set background=dark

set relativenumber
set wrap
set linebreak
set whichwrap+=<,>,[,],h,l

set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab
set ignorecase
set smartcase

" backup directory
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
Plug 'neomake/neomake'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
call plug#end()

" eye candy
let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
colorscheme solarized

" display fixes
match LineNr /\s\+$/
autocmd bufenter * highlight CursorLineNr ctermfg=10 ctermbg=0
autocmd bufenter * set vb t_vb=
autocmd VimLeave * set guicursor=a:ver25

" filetype fixes
autocmd FileType html,xhtml setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType make setlocal noexpandtab

" for Colemak
let mapleader=","
noremap , <Nop>
noremap J K
noremap K L
noremap L J
noremap j h
noremap h k
noremap k j
noremap gj gh
noremap gh gk
noremap gk gj
noremap <C-w>j <C-w>h
noremap <C-w>h <C-w>k
noremap <C-w>k <C-w>j
noremap <Leader>l <C-w>l
noremap <Leader>j <C-w>h
noremap <Leader>h <C-w>k
noremap <Leader>k <C-w>j

" for convenience
noremap <Leader>t zt
noremap <Leader>b zb
noremap <Leader><Leader> zz
noremap <Space> :
noremap : ,
vnoremap tn <Esc>
inoremap tn <Esc>
inoremap {} {<CR>}<Esc>O
nnoremap Y y$
nnoremap <silent> <CR> :nohlsearch<CR>
nnoremap <Leader>n :E<CR>
nnoremap <Leader>m :Neomake!<CR>
command! -bang -nargs=* -complete=file Make Neomake! <args>
command! PU PlugUpdate | PlugUpgrade
