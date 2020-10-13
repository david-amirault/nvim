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
" Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'glts/vim-textobj-comment'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'sgur/vim-textobj-parameter'
call plug#end()

" eye candy
let $GIT_EDITOR = 'nvr -cc split --remote-wait'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
colorscheme solarized
match LineNr /\s\+$/

" ========
" Commands
" ========

" filetype fixes
autocmd FileType html,xhtml setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType make setlocal noexpandtab
autocmd FileType c,cpp setlocal commentstring=//\ %s
autocmd FileType gitcommit,gitrebase,gitconfig setlocal bufhidden=delete
autocmd VimLeave * set guicursor=a:ver25

" popup terminal
function! Popterm(...)
    " create popterm if absent
    let pnr = bufnr('popterm')
    if pnr <= 0
        terminal
        keepalt file popterm
        if expand('#') == 'popterm'
            enew
        else
            execute "normal \<C-^>"
        endif
        let pnr = bufnr('popterm')
    endif
    " run command if given
    let cnr = bufnr('%')
    execute pnr.'buffer'
    if a:0 > 1
        call jobsend(b:terminal_job_id, a:2)
    endif
    " toggle state if needed
    if (a:0 > 0 && a:1 == 0) || (a:0 == 0 && pnr == cnr)
        execute "normal \<C-^>"
    else
        startinsert
    endif
endfunction

" software update
command! PU PlugUpdate | PlugUpgrade
command! PC PlugClean

" ========
" Mappings
" ========

" leader
let mapleader=','
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
nnoremap <silent> <Leader>f :call Popterm()<CR>
tnoremap <silent> <Leader>f <C-\><C-n>:call Popterm()<CR>
nnoremap - :call Popterm(1, 'cd '.expand('%:p:h')."\n")<CR>
nnoremap <Leader>m :call Popterm(1, 'make ')<CR>
nnoremap <Leader>p :GFiles<CR>
nnoremap <Leader>g :Rg<Space>
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
