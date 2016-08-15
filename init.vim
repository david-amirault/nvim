" David Amirault

" reasonable defaults
set nobackup
set nowritebackup
if !isdirectory($HOME.'/.config/nvim/tmp')
    if !isdirectory($HOME.'/.config/nvim')
        execute 'silent !mkdir ~/.config/nvim'
    endif
    execute 'silent !mkdir ~/.config/nvim/tmp'
endif
set dir=~/.config/nvim/tmp//

set relativenumber
set showcmd
set wrap
set linebreak

set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab
set ignorecase
set smartcase

"-------------------------------------------------------------------------------

" plugins
let hasPlug=1
if !isdirectory($HOME.'/.config/nvim/bundle')
    execute 'silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    let hasPlug=0
endif

call plug#begin($HOME.'/.config/nvim/bundle')
Plug 'benekastah/neomake'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-surround'
call plug#end()
if hasPlug==0
    PlugInstall
endif
filetype plugin indent on
syntax enable

let g:solarized_termcolors=256
let g:airline_theme='jellybeans'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:NERDTreeMapOpenSplit='s'
let g:NERDTreeMapOpenVSplit='v'
let g:UltiSnipsExpandTrigger='<C-a>'
let g:UltiSnipsListSnippets='<C-s>'
let g:UltiSnipsJumpForwardTrigger='<C-f>'
let g:UltiSnipsJumpBackwardTrigger='<C-b>'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/bundle/vim-snippets/UltiSnips', $HOME.'/nvim/customsnippets']

"-------------------------------------------------------------------------------

" eye candy
set background=dark
colorscheme solarized
autocmd bufenter * highlight CursorLineNr ctermfg=8 ctermbg=0
autocmd bufenter * set vb t_vb=

" filetype fixes
autocmd FileType cpp,java setlocal equalprg=astyle\ -A1sCSNLYpHUEk1xjcn
autocmd FileType python setlocal makeprg=pylint
autocmd FileType python nnoremap <buffer> <Leader>m :Neomake<CR>
autocmd FileType html,xhtml setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType make setlocal noexpandtab

" for Colemak
let mapleader=","
noremap ; :
noremap J K
noremap K L
noremap L J
noremap j h
noremap h k
noremap k j
noremap <C-h> <C-w><Up>
noremap <C-j> <C-w><Left>
noremap <C-k> <C-w><Down>
noremap <C-l> <C-w><Right>
noremap <C-,> 5<C-w><
noremap <C-.> 5<C-w>>
noremap tn <Esc>
inoremap tn <Esc>
nnoremap Y y$
nnoremap <silent> <CR> :nohlsearch<CR>:redraw!<CR>
nnoremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Leader>m :Neomake!<CR>
nnoremap <Leader>r :!make run<CR>
nnoremap <Leader>q :copen<CR>
nnoremap <Leader>x :cclose<CR>
nnoremap <Leader>f :cnext<CR>
nnoremap <Leader>b :cprevious<CR>
