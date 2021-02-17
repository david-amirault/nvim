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
Plug 'ackyshake/VimCompletesMe'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'glts/vim-textobj-comment'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'sgur/vim-textobj-parameter'
call plug#end()

" settings
let $GIT_EDITOR = "nvr -cc split --remote-wait"
let g:fzf_layout = { "window": { "width": 0.9, "height": 0.6 } }
let g:vim_textobj_parameter_mapping = "a"
colorscheme solarized

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

" autocommands
autocmd BufWinEnter * match LineNr /\s\+$/
autocmd FileType html,xhtml setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType make setlocal noexpandtab
autocmd FileType c,cpp setlocal commentstring=//\ %s
autocmd FileType gitcommit,gitrebase,gitconfig setlocal bufhidden=delete
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
nnoremap <Leader>m :call Popterm(1, "make")<CR>

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
