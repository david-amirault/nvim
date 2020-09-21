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

" buffers and tabs
set hidden
set showtabline=0

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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'glts/vim-textobj-comment'
Plug 'Julian/vim-textobj-variable-segment'
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
let g:dispatch_no_tmux_make=1
let g:netrw_fastbrowse=0
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
colorscheme solarized

" display fixes
match LineNr /\s\+$/
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
nnoremap Y y$
nnoremap <silent> <CR> :nohlsearch<CR>

" escape
tnoremap tn <C-\><C-n>
vnoremap tn <Esc>
inoremap tn <Esc>

" fuzzy find
nnoremap <Leader>p :GFiles<CR>
nnoremap <Leader>g :Rg<CR>
nnoremap <Leader>s :Buffers<CR>
nnoremap <Leader>r :History:<CR>

" copy to attached terminal using the yank(1) script:
" https://github.com/sunaku/home/blob/master/bin/yank
function! Yank(text) abort
    let escape = system(stdpath('config').'/yank', a:text)
    if v:shell_error
        echoerr escape
    else
        call writefile([escape], '/dev/tty', 'b')
    endif
endfunction
noremap <silent> <Leader>y y:<C-U>call Yank(@0)<CR>

" ===============
" Code Completion
" ===============

" " coc completion
" let g:python3_host_prog = '/usr/local/bin/python3.8'
" let g:coc_node_path = '/path/to/node'

" " coc extensions
" let g:coc_global_extensions = [
"         \ 'coc-pyright',
"         \ ]

" " 300ms trigger latency
" set updatetime=300

" " use <Tab> for trigger completion with characters ahead and navigate
" inoremap <silent> <expr> <Tab>
"         \ pumvisible() ? "\<C-n>" :
"         \ <SID>check_back_space() ? "\<Tab>" :
"         \ coc#refresh()
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1] =~# '\s'
" endfunction

" " use <C-Space> to trigger completion
" inoremap <silent> <expr> <C-Space> coc#refresh()

" " use <CR> to confirm completion
" if exists('*complete_info')
"     inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"     inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

" " navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" " goto code navigation
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " show documentation
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"     if (index(['vim','help'], &filetype) >= 0)
"         execute 'h '.expand('<cword>')
"     else
"         call CocAction('doHover')
"     endif
" endfunction

" " format selected code
" xmap <Leader>f <Plug>(coc-format-selected)
" nmap <Leader>f <Plug>(coc-format-selected)
