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

set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab
set ignorecase
set smartcase

"---------------------------------------------------------------------------

" plugins
let hasPlug=1
if !isdirectory($HOME.'/.config/nvim/bundle')
    execute 'silent !curl -fLo '.$HOME.'/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    let hasPlug=0
endif

call plug#begin($HOME.'/.config/nvim/bundle')
Plug 'benekastah/neomake'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-surround'
call plug#end()
if hasPlug==0
    PlugInstall
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
let g:UltiSnipsExpandTrigger='<C-a>'
let g:UltiSnipsListSnippets='<C-r>'
let g:UltiSnipsJumpForwardTrigger='<C-f>'
let g:UltiSnipsJumpBackwardTrigger='<C-b>'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/bundle/vim-snippets/UltiSnips', $HOME.'/.config/nvim/customsnippets']

"---------------------------------------------------------------------------

" eye candy
set background=dark
colorscheme solarized
match LineNr /\s\+$/
autocmd bufenter * highlight CursorLineNr ctermfg=10 ctermbg=0
autocmd bufenter * set vb t_vb=
autocmd VimLeave * set guicursor=a:ver25-blinwait700-blinkoff400-blinkon250

" filetype fixes
autocmd FileType c,cpp setlocal equalprg=astyle\ -A1NLYpHUk1xbxjxfcn
autocmd FileType java setlocal equalprg=astyle\ -A2NLYpHUk1xbjxfcn
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
nnoremap Y y$
nnoremap <silent> <CR> :nohlsearch<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>m :Neomake!<CR>
