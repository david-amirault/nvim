" David Amirault

" ================
" General Settings
" ================

" mouse
set mouse=a
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
let g:plugged=stdpath("data")."/plugged"
if !isdirectory(g:plugged)
    execute "silent !mkdir -p ".g:plugged
    let g:autoload=stdpath("data")."/site/autoload/plug.vim"
    let g:url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    execute "silent !curl -fLo ".g:autoload." --create-dirs ".g:url
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin(g:plugged)
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'bps/vim-textobj-python'
Plug 'glts/vim-textobj-comment'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'sgur/vim-textobj-parameter'
call plug#end()

" settings
let $GIT_EDITOR = "nvr -cc split --remote-wait"
let g:fzf_layout = { "window": { "width": 0.9, "height": 0.6 } }
let g:textobj_python_no_default_key_mappings = 1
let g:vim_textobj_parameter_mapping = "a"
colorscheme solarized
match LineNr /\s\+$/

" =========
" Vimscript
" =========

" popup terminal
function! Popterm(...)
    " create popterm if absent
    let pnr = bufnr("popterm")
    if pnr <= 0
        terminal
        keepalt file popterm
        if expand("#") == "popterm"
            enew
        else
            execute "normal \<C-^>"
        endif
        let pnr = bufnr("popterm")
    endif
    " run command if given
    let cnr = bufnr("%")
    execute pnr."buffer"
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

" copy to attached terminal using the yank(1) script:
" https://github.com/sunaku/home/blob/master/bin/yank
function! Yank(text) abort
    let escape = system(stdpath("config")."/yank", a:text)
    if v:shell_error
        echoerr escape
    else
        call writefile([escape], "/dev/tty", "b")
    endif
endfunction

function! YankOp(type, ...)
    if a:0
        silent execute "normal! gvy"
    elseif a:type == "line"
        silent execute "normal! '[V']y"
    else
        silent execute "normal! `[v`]y"
    endif
    call Yank(@0)
endfunction

function! SetYankOp()
    set opfunc=YankOp
    return "g@"
endfunction

" vim-textobj-python mappings
function! PythonStartup()
    call textobj#user#map('python', {
            \     'class': {
            \         'select-a': '<buffer>al',
            \         'select-i': '<buffer>il',
            \         'move-n': '<buffer>]pl',
            \         'move-p': '<buffer>[pl',
            \     },
            \     'function': {
            \         'select-a': '<buffer>af',
            \         'select-i': '<buffer>if',
            \         'move-n': '<buffer>]pf',
            \         'move-p': '<buffer>[pf',
            \     }
            \ })
endfunction

function! FixFormatter()
    xnoremap <silent> <buffer> gq gq
    nnoremap <silent> <buffer> gq gq
endfunction

" autocommands
autocmd FileType html,xhtml setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType make setlocal noexpandtab
autocmd FileType c,cpp setlocal commentstring=//\ %s
autocmd FileType gitcommit,gitrebase,gitconfig,conf setlocal bufhidden=delete
autocmd FileType python call PythonStartup()
autocmd FileType python,conf call FixFormatter()
autocmd VimLeave * set guicursor=a:ver25

" commands
command! PU PlugUpdate | PlugUpgrade
command! PC PlugClean

" ========
" Mappings
" ========

" leader
let mapleader=","
noremap , <Nop>

" scroll
noremap <Leader>t zt
noremap <Leader>b zb
noremap <Leader><Leader> zz
noremap <Leader>w <C-w>

" convenience mappings
noremap <Space> :
noremap : ,
nnoremap <silent> <CR> :nohlsearch<CR>

" escape
tnoremap tn <C-\><C-n>
vnoremap tn <Esc>
inoremap tn <Esc>

" popup terminal
nnoremap <silent> <Leader>f :call Popterm()<CR>
tnoremap <silent> <Leader>f <C-\><C-n>:call Popterm()<CR>
nnoremap - :call Popterm(1, "cd ".expand("%:p:h")."\n")<CR>
nnoremap <Leader>m :call Popterm(1, "make ")<CR>

" yank
nnoremap Y y$
nnoremap <silent> <expr> <Leader>y SetYankOp()
nnoremap <silent> <expr> <Leader>yy SetYankOp()."_"
nnoremap <silent> <expr> <Leader>Y SetYankOp()."$"
vnoremap <silent> <Leader>y :<C-u>call YankOp(visualmode(), 1)<CR>

" fuzzy find
nnoremap <Leader>p :GFiles<CR>
nnoremap <Leader>g :Rg<Space>
nnoremap <Leader>s :Buffers<CR>
nnoremap <Leader>r :History:<CR>

" ===============
" Code Completion
" ===============

" coc completion
let g:python3_host_prog = "/path/to/python"

" 300ms trigger latency
set updatetime=300

" use <Tab> for trigger completion with characters ahead and navigate
inoremap <silent> <expr> <Tab>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<Tab>" :
        \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col(".") - 1
    return !col || getline(".")[col - 1] =~# '\s'
endfunction

" use <CR> to confirm completion
if exists("*complete_info")
    inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" goto code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" rename symbol
nmap <silent> gn <Plug>(coc-rename)

" format selected code
xmap <silent> gq <Plug>(coc-format-selected)
nmap <silent> gq <Plug>(coc-format-selected)
