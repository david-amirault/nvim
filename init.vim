" David Amirault

" ================
" General Settings
" ================

" visual
set guicursor+=a:blinkon100
set relativenumber

" tab
set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab

" search
set ignorecase
set smartcase

" buffers
set hidden

" tab pages
set showtabline=0

" ====================
" Plugin Configuration
" ====================

" plugin initialization
let g:plugged=stdpath('data').'/plugged'
if !isdirectory(g:plugged)
    execute 'silent !mkdir -p '.g:plugged
    let g:autoload=stdpath('data').'/site/autoload/plug.vim'
    let g:url='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    execute 'silent !curl -fLo '.g:autoload.' --create-dirs '.g:url
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin(g:plugged)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'glts/vim-textobj-comment'
Plug 'Julian/vim-textobj-variable-segment'
call plug#end()

" settings
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:floaterm_width=0.9
let g:floaterm_height=0.6
let g:floaterm_gitcommit='split'

" eye candy
colorscheme solarized
match LineNr /\s\+$/

" ========
" Commands
" ========

" filetype fixes
autocmd FileType html,xhtml setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType make setlocal noexpandtab
autocmd FileType c,cpp setlocal commentstring=//\ %s
autocmd VimLeave * set guicursor=a:ver25

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
noremap <Leader>w <C-w>

" convenience mappings
noremap <Space> :
noremap : ,
nnoremap Y y$
nnoremap <silent> <CR> :nohlsearch<CR>

" escape
tnoremap tn <C-\><C-n>
vnoremap tn <Esc>
inoremap tn <Esc>

" plugins
let g:floaterm_keymap_toggle='<Leader>f'
nnoremap <silent> - :FloatermSend cd %:h<CR>
nnoremap <Leader>g :FloatermSend git 
nnoremap <Leader>p :GFiles<CR>
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

" " rename symbol
" nmap <silent> gn <Plug>(coc-rename)

" " format selected code
" xmap <silent> gq <Plug>(coc-format-selected)
" nmap <silent> gq <Plug>(coc-format-selected)
