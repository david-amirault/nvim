" David Amirault

" reasonable defaults
set clipboard+=unnamedplus
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

set nobackup
set nowritebackup
if !isdirectory($HOME.'/.config/nvim/tmp')
    execute 'silent !mkdir -p '.$HOME.'/.config/nvim/tmp'
endif
set dir=$HOME/.config/nvim/tmp//

set relativenumber
set wrap
set linebreak
set whichwrap+=<,>,h,l

set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab
set ignorecase
set smartcase

"---------------------------------------------------------------------------

" plugins
let hasVundle=1
if !isdirectory($HOME.'/.config/nvim/bundle')
    execute 'silent !mkdir -p '.$HOME.'/.config/nvim/bundle'
    execute 'silent !git clone https://github.com/VundleVim/Vundle.vim.git '.$HOME.'/.config/nvim/bundle/Vundle.vim'
    let hasVundle=0
endif

filetype off
set rtp+=$HOME/.config/nvim/bundle/Vundle.vim
call vundle#begin($HOME.'/.config/nvim/bundle')
Plugin 'VundleVim/Vundle.vim'
Plugin 'neomake/neomake'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
call vundle#end()
if hasVundle==0
    PluginInstall
endif
filetype plugin indent on
syntax enable

let g:airline_theme='base16'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:NERDTreeShowHidden=1
let g:NERDTreeMapOpenSplit='s'
let g:NERDTreeMapOpenVSplit='v'
let g:NERDTreeMapJumpFirstChild='J'
let g:NERDTreeMapJumpLastChild='L'

"---------------------------------------------------------------------------

" eye candy
set background=dark
colorscheme solarized
match LineNr /\s\+$/
autocmd bufenter * highlight CursorLineNr ctermfg=10 ctermbg=0
autocmd bufenter * set vb t_vb=
autocmd VimLeave * set guicursor=a:ver25-blinwait700-blinkoff400-blinkon250

" filetype fixes
autocmd FileType html,xhtml setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType make setlocal noexpandtab
autocmd FileType md2 setlocal filetype=markdown

" for Colemak
let mapleader=","
noremap ; :
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
noremap <Leader>t zt
noremap <Leader>b zb
noremap <Leader><Leader> zz
noremap tn <Esc>
inoremap tn <Esc>
inoremap {} {<CR>}<Esc>O
nnoremap Y y$
nnoremap <silent> <CR> :nohlsearch<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>m :Neomake!<CR>
