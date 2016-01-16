" David Amirault

" reasonable defaults
set clipboard+=unnamedplus

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
Plug 'Shougo/deoplete.nvim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'bling/vim-airline'
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
let g:deoplete#enable_at_startup=1
let g:UltiSnipsExpandTrigger='<C-a>'
let g:UltiSnipsJumpForwardTrigger='<C-f>'
let g:UltiSnipsJumpBackwardTrigger='<C-b>'
let g:UltiSnipsSnippetDirectories=[$HOME.'/nvim/customsnippets', $HOME.'/.config/nvim/bundle/vim-snippets/UltiSnips']

"-------------------------------------------------------------------------------

" eye candy
set background=dark
colorscheme solarized
match LineNr /\s\+$/
autocmd bufenter * highlight CursorLineNr ctermfg=10 ctermbg=0
autocmd bufenter * set vb t_vb=

" filetype fixes
autocmd FileType cpp,java setlocal equalprg=astyle\ -A1sCSNLYpHUEk1xjcn
autocmd FileType python setlocal makeprg=pylint
autocmd BufWritePost *.py Neomake
autocmd FileType html,xhtml setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType make setlocal noexpandtab

function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
   else
      return "\<C-n>"
   endif
endfunction
inoremap <Tab> <C-r>=CleverTab()<CR>

function! CleverSTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<S-Tab>"
   else
      return "\<C-p>"
   endif
endfunction
inoremap <S-Tab> <C-r>=CleverSTab()<CR>

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
nnoremap Y y$
nnoremap <silent> <CR> :nohlsearch<CR>:redraw!<CR>
nnoremap <Leader>m :Neomake!<CR>
nnoremap <Leader>r :!make run<CR>
nnoremap <Leader>o :copen<CR>
nnoremap <Leader>x :cclose<CR>
nnoremap <Leader>f :cnext<CR>
nnoremap <Leader>b :cprevious<CR>
nnoremap <Leader>t :NERDTreeToggle<CR>
